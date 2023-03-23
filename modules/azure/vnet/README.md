## Description

Module to create Virtual Network. It uses 'subnet' module to create subnets.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ../subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of your Resource Group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to create within the Azure Virtual Network. | <pre>list(object({<br>    label            = string<br>    address_prefixes = list(string)<br>    route_table      = optional(object({ name = string, resource_group_name = string }))<br>    nat_gateway      = optional(object({ name = string, resource_group_name = string }))<br>    nsg              = optional(object({ name = string, resource_group_name = string }))<br>  }))</pre> | <pre>[<br>  {<br>    "address_prefixes": [<br>      "10.1.1.0/24"<br>    ],<br>    "label": "main",<br>    "nat_gateway": null,<br>    "nsg": null,<br>    "route_table": null<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space to be used for the Azure Virtual Network. | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The address space to be used for the Azure Virtual Network. |
| <a name="output_id"></a> [id](#output\_id) | Azure Virtual Network ID. |
| <a name="output_name"></a> [name](#output\_name) | Azure Virtual Network name. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name. |
