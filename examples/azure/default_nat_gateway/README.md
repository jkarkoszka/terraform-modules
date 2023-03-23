## Description

Module with example usage of 'default_nat_gateway' module.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default_nat_gateway"></a> [default\_nat\_gateway](#module\_default\_nat\_gateway) | ../../../modules/azure/default_nat_gateway | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../../modules/azure/rg | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | `"westeurope"` | no |
| <a name="input_nat_sku_name"></a> [nat\_sku\_name](#input\_nat\_sku\_name) | (Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. | `string` | `"Standard"` | no |
| <a name="input_number_of_ip_addresses"></a> [number\_of\_ip\_addresses](#input\_number\_of\_ip\_addresses) | (Optional) Number of IP addresses for NAT Gateway. Defaults to 1. | `number` | `"1"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_public_ip_sku_name"></a> [public\_ip\_sku\_name](#input\_public\_ip\_sku\_name) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_nat_gateway"></a> [default\_nat\_gateway](#output\_default\_nat\_gateway) | Whole output from 'default\_nat\_gateway' module. |
