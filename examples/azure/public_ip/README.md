## Description

Module with example usage of 'public_ip' module.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_public_ip"></a> [public\_ip](#module\_public\_ip) | ../../../modules/azure/public_ip | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../../modules/azure/rg | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Whole output from 'public\_ip' module. |
