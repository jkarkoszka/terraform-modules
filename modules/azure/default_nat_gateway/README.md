## Description

Module to create NAT Gateway with one Public IP. It uses low level modules to create these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.42 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway) | ../nat_gateway | n/a |
| <a name="module_public_ip"></a> [public\_ip](#module\_public\_ip) | ../public_ip | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location | `string` | n/a | yes |
| <a name="input_nat_sku_name"></a> [nat\_sku\_name](#input\_nat\_sku\_name) | (Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. | `string` | `"Standard"` | no |
| <a name="input_number_of_ip_addresses"></a> [number\_of\_ip\_addresses](#input\_number\_of\_ip\_addresses) | (Optional) Number of IP addresses for NAT Gateway. Defaults to 1. | `number` | `"1"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `string` | n/a | yes |
| <a name="input_public_ip_sku_name"></a> [public\_ip\_sku\_name](#input\_public\_ip\_sku\_name) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of your Resource Group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway"></a> [nat\_gateway](#output\_nat\_gateway) | Whole output from 'nat\_gateway' module. |
