## Description

Module with example usage of 'sp' module.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sp"></a> [sp](#module\_sp) | ../../../modules/azure/sp | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label. | `string` | `"abcdfg"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix. | `string` | `"tftest"` | no |
| <a name="input_role"></a> [role](#input\_role) | The name of a role for the service principal. | `string` | `"Contributor"` | no |
| <a name="input_rotation_days"></a> [rotation\_days](#input\_rotation\_days) | (Number) Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. | `number` | `31` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | A list of scopes the role assignment applies to. Default is subscription wide. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources. | `map(string)` | <pre>{<br>  "tfTest": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
