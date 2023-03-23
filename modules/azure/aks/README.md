## Description

Module to create AKS cluster on Azure Cloud.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.42 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.42 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | The properties of the default node pool. | <pre>object({<br>    name                 = string<br>    vnet_subnet_id       = string<br>    min_count            = optional(number)<br>    node_count           = optional(number)<br>    max_count            = optional(number)<br>    vm_size              = optional(string)<br>    type                 = optional(string)<br>    enable_auto_scaling  = optional(bool)<br>    zones                = optional(list(string))<br>    orchestrator_version = optional(string)<br>    max_surge_on_upgrade = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_default_node_pool_defaults"></a> [default\_node\_pool\_defaults](#input\_default\_node\_pool\_defaults) | The default values of properties of the default node pool. | <pre>object({<br>    min_count            = number<br>    node_count           = number<br>    max_count            = number<br>    vm_size              = string<br>    type                 = string<br>    enable_auto_scaling  = bool<br>    zones                = list(string)<br>    orchestrator_version = string<br>    max_surge_on_upgrade = string<br>  })</pre> | <pre>{<br>  "enable_auto_scaling": true,<br>  "max_count": 1,<br>  "max_surge_on_upgrade": "100%",<br>  "min_count": 1,<br>  "node_count": 1,<br>  "orchestrator_version": "1.24.9",<br>  "type": "VirtualMachineScaleSets",<br>  "vm_size": "Standard_D2_v2",<br>  "zones": []<br>}</pre> | no |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | `"10.0.0.10"` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created. | `string` | `"172.17.0.1/16"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `"1.24.9"` | no |
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | n/a | yes |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created. | `string` | `"standard"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created. | `string` | `"kubenet"` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Changing this forces a new resource to be created. | `string` | `"loadBalancer"` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | The CIDR to use for pod IP addresses. This field can only be set when network\_plugin is set to kubenet. Changing this forces a new resource to be created. | `string` | `"10.244.0.0/16"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of your Resource Group. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal) | The service principal for the cluster. | <pre>object({<br>    client_id     = string<br>    client_secret = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | `{}` | no |
| <a name="input_user_node_pool_defaults"></a> [user\_node\_pool\_defaults](#input\_user\_node\_pool\_defaults) | The default values of properties of the user node pools. | <pre>object({<br>    min_count            = number<br>    node_count           = number<br>    max_count            = number<br>    vm_size              = string<br>    type                 = string<br>    enable_auto_scaling  = bool<br>    zones                = list(string)<br>    orchestrator_version = string<br>    max_surge_on_upgrade = string<br>  })</pre> | <pre>{<br>  "enable_auto_scaling": true,<br>  "max_count": 1,<br>  "max_surge_on_upgrade": "100%",<br>  "min_count": 1,<br>  "node_count": 1,<br>  "orchestrator_version": "1.24.9",<br>  "type": "VirtualMachineScaleSets",<br>  "vm_size": "Standard_B2ms",<br>  "zones": []<br>}</pre> | no |
| <a name="input_user_node_pools"></a> [user\_node\_pools](#input\_user\_node\_pools) | The list of object with properties of additional user node pools. | <pre>list(object({<br>    name                 = string<br>    vnet_subnet_id       = string<br>    min_count            = optional(number)<br>    node_count           = optional(number)<br>    max_count            = optional(number)<br>    vm_size              = optional(string)<br>    type                 = optional(string)<br>    enable_auto_scaling  = optional(bool)<br>    zones                = optional(list(string))<br>    orchestrator_version = optional(string)<br>    max_surge_on_upgrade = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Client certificate for authenticating to cluster. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Client key for authenticating to cluster. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The base64 encoded certificate data required to communicate with your cluster. Add this to the certificate-authority-data section of the kubeconfig file for your cluster. |
| <a name="output_host"></a> [host](#output\_host) | The endpoint for your Kubernetes API server. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The kubeconfig for the cluster after it is created |
