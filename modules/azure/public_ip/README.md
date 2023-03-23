## Description

Module to create static Public IP.

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
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of your Resource Group | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources | `map(string)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Public IP ID |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | Public IP |
| <a name="output_name"></a> [name](#output\_name) | Public IP name |
