## Description

Module to set up local Kuberetes Cluster (https://kind.sigs.k8s.io/).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.9.0 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | ~> 0.0.16 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.9.0 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | ~> 0.0.16 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metal_lb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kind_cluster.cluster](https://registry.terraform.io/providers/tehcyx/kind/latest/docs/resources/cluster) | resource |
| [kubectl_manifest.metal_lb_advertisement](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.metal_lb_ip_address_pool](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [null_resource.get_ip_range_for_metal_lb](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [local_file.ip_range_for_metal_lb](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [template_file.cilium_values](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.metal_lb_advertisement_manifest](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.metal_lb_ip_address_pool_manifest](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes version (tag of the kindest/node docker image) | `string` | `"kindest/node:v1.24.7"` | no |
| <a name="input_label"></a> [label](#input\_label) | The label | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Client certificate for authenticating to cluster. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Client key for authenticating to cluster. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The base64 encoded certificate data required to communicate with your cluster. Add this to the certificate-authority-data section of the kubeconfig file for your cluster. |
| <a name="output_host"></a> [host](#output\_host) | The endpoint for your Kubernetes API server. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The kubeconfig for the cluster after it is created |
