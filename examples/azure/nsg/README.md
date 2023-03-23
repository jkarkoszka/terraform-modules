## Description

Module with example usage of 'nsg' module.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ../../../modules/azure/nsg | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../../modules/azure/rg | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location. | `string` | `"westeurope"` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | Network security rules to add to all subnet. | <pre>list(object({<br>    name                                       = string,<br>    direction                                  = string<br>    access                                     = string<br>    protocol                                   = string<br>    description                                = string<br>    source_port_range                          = optional(string)<br>    source_port_ranges                         = optional(list(string))<br>    destination_port_range                     = optional(string)<br>    destination_port_ranges                    = optional(list(string))<br>    source_address_prefix                      = optional(string)<br>    source_address_prefixes                    = optional(list(string))<br>    source_application_security_group_ids      = optional(list(string))<br>    destination_address_prefix                 = optional(string)<br>    destination_address_prefixes               = optional(list(string))<br>    destination_application_security_group_ids = optional(list(string))<br>  }))</pre> | <pre>[<br>  {<br>    "access": "Allow",<br>    "description": "Allow 443 port traffic to 192.168.0.1",<br>    "destination_address_prefix": "192.168.0.1",<br>    "destination_port_range": "443",<br>    "direction": "Inbound",<br>    "name": "TCP-443-Internet",<br>    "priority": 501,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "Internet",<br>    "source_port_range": "*"<br>  }<br>]</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg"></a> [nsg](#output\_nsg) | Whole output from 'ngs' module. |
