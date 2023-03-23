## Description

Module with example usage of 'subnet' module.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default_nat_gateway"></a> [default\_nat\_gateway](#module\_default\_nat\_gateway) | ../../../modules/azure/default_nat_gateway | n/a |
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ../../../modules/azure/nsg | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../../modules/azure/rg | n/a |
| <a name="module_route_table"></a> [route\_table](#module\_route\_table) | ../../../modules/azure/route_table | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ../../../modules/azure/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | If NAT Gateway should be created and attached to subnet. | `bool` | `false` | no |
| <a name="input_create_nsg"></a> [create\_nsg](#input\_create\_nsg) | If Network Security Group should be created and attached to subnet. | `bool` | `false` | no |
| <a name="input_create_route_table"></a> [create\_route\_table](#input\_create\_route\_table) | If Route Table should be created and attached to subnet. | `bool` | `false` | no |
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | `"westeurope"` | no |
| <a name="input_nat_sku_name"></a> [nat\_sku\_name](#input\_nat\_sku\_name) | (Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. Only used when NAT Gateway is created. | `string` | `"Standard"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_public_ip_sku_name"></a> [public\_ip\_sku\_name](#input\_public\_ip\_sku\_name) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Only used when NAT Gateway is created. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | (Required) The address prefixes to use for the subnet. | `list(string)` | <pre>[<br>  "10.1.1.0/24"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space to be used for the Azure Virtual Network. | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_nat_gateway"></a> [default\_nat\_gateway](#output\_default\_nat\_gateway) | Whole output from 'default\_nat\_gateway' module. |
| <a name="output_nsg"></a> [nsg](#output\_nsg) | Whole output from 'nsg' module. |
| <a name="output_rg"></a> [rg](#output\_rg) | Whole output from 'rg' module. |
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | Whole output from 'route\_table' module. |
