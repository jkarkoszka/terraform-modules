## Description

Module with example usage of 'default_vnet' module.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default_vnet"></a> [default\_vnet](#module\_default\_vnet) | ../../../modules/azure/default_vnet | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../../modules/azure/rg | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | (Required) The address prefixes to use for the subnet. | `list(string)` | <pre>[<br>  "10.1.1.0/24"<br>]</pre> | no |
| <a name="input_subnet_label"></a> [subnet\_label](#input\_subnet\_label) | (Optional) Label used for the subnet name. Defaults to 'main'. | `string` | `"main"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space to be used for the Azure Virtual Network. | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_vnet"></a> [default\_vnet](#output\_default\_vnet) | Whole output from 'default\_vnet' module. |
