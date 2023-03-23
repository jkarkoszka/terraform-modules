## Description

Module to create Azure Kubernetes Service and Virtual Network with one subnet and Route Table and Network Security Group assigned to that subnet. It also creates Service Principal for AKS. It uses low level modules to create these resources.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../../../modules/azure/aks | n/a |
| <a name="module_default_vnet"></a> [default\_vnet](#module\_default\_vnet) | ../../../modules/azure/default_vnet | n/a |
| <a name="module_sp_for_aks"></a> [sp\_for\_aks](#module\_sp\_for\_aks) | ../../../modules/azure/sp | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool_name"></a> [default\_node\_pool\_name](#input\_default\_node\_pool\_name) | (Optional) Default node pool name. Defaults to 'nodepool'. | `string` | `"nodepool"` | no |
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
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | (Required) The address prefixes to use for the subnet. | `list(string)` | <pre>[<br>  "10.1.1.0/24"<br>]</pre> | no |
| <a name="input_subnet_label"></a> [subnet\_label](#input\_subnet\_label) | (Optional) Label used for the subnet name. Defaults to 'main'. | `string` | `"main"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_user_node_pools"></a> [user\_node\_pools](#input\_user\_node\_pools) | The list of object with properties of additional user node pools. | <pre>list(object({<br>    name                 = string<br>    vnet_subnet_id       = string<br>    min_count            = optional(number)<br>    node_count           = optional(number)<br>    max_count            = optional(number)<br>    vm_size              = optional(string)<br>    type                 = optional(string)<br>    enable_auto_scaling  = optional(bool)<br>    zones                = optional(list(string))<br>    orchestrator_version = optional(string)<br>    max_surge_on_upgrade = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space to be used for the Azure Virtual Network. | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks"></a> [aks](#output\_aks) | Whole output from 'aks' module. |
| <a name="output_default_vnet"></a> [default\_vnet](#output\_default\_vnet) | Whole output from 'default\_vnet' module. |
