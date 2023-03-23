terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.16"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
  }
}

resource "kind_cluster" "cluster" {
  name           = "${var.prefix}-${var.label}-kind-cluster"
  wait_for_ready = true
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    networking {
      disable_default_cni = true
      kube_proxy_mode     = "none"
    }
    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      image = var.k8s_version
    }

    node {
      role = "worker"

      image = var.k8s_version
    }
  }
}

data "template_file" "cilium_values" {
  template = file("${path.module}/config/cilium-values.yaml")
  vars     = {
    kind_cluster_name = kind_cluster.cluster.name
  }
}

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.13.1"
  namespace  = "kube-system"
  values     = [data.template_file.cilium_values.rendered]
}

resource "null_resource" "get_ip_range_for_metal_lb" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "${path.module}/config/get-ip-range-for-metal-lb.sh > ip-range-for-metal-lb.txt"
  }
  depends_on = [helm_release.cilium]
}

data "local_file" "ip_range_for_metal_lb" {
  filename   = "ip-range-for-metal-lb.txt"
  depends_on = [null_resource.get_ip_range_for_metal_lb]
}

resource "helm_release" "metal_lb" {
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.13.9"
  name             = "metallb"
  namespace        = "metallb-system"
  create_namespace = true
}

data "template_file" "metal_lb_ip_address_pool_manifest" {
  template = file("${path.module}/config/metal-lb-ip-address-pool-manifest.yaml")
  vars     = {
    ip_range = data.local_file.ip_range_for_metal_lb.content
  }
}

resource "kubectl_manifest" "metal_lb_ip_address_pool" {
  yaml_body  = data.template_file.metal_lb_ip_address_pool_manifest.rendered
  depends_on = [helm_release.metal_lb, data.template_file.metal_lb_ip_address_pool_manifest]
}

data "template_file" "metal_lb_advertisement_manifest" {
  template = file("${path.module}/config/metal-lb-l2advertisement-manifest.yaml")
}

resource "kubectl_manifest" "metal_lb_advertisement" {
  yaml_body  = data.template_file.metal_lb_advertisement_manifest.rendered
  depends_on = [helm_release.metal_lb, data.template_file.metal_lb_advertisement_manifest]
}
