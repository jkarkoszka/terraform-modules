provider "helm" {
  kubernetes {
    host                   = module.kind_cluster.host
    cluster_ca_certificate = base64decode(module.kind_cluster.cluster_ca_certificate)
    client_certificate     = base64decode(module.kind_cluster.client_certificate)
    client_key             = base64decode(module.kind_cluster.client_key)
  }
}

provider "kubectl" {
  host                   = module.kind_cluster.host
  cluster_ca_certificate = base64decode(module.kind_cluster.cluster_ca_certificate)
  client_certificate     = base64decode(module.kind_cluster.client_certificate)
  client_key             = base64decode(module.kind_cluster.client_key)
  load_config_file       = false
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}
