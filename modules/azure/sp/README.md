## Description

Module to create Service Principal.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.36 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.42 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.36 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.42 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.sp_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_role_assignment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [time_rotating.tr](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_sleep.wait_for_aad_propagation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_role_definition.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The name of a role for the service principal. | `string` | `"Contributor"` | no |
| <a name="input_rotation_days"></a> [rotation\_days](#input\_rotation\_days) | (Number) Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. | `number` | `31` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | A list of scopes the role assignment applies to. Default is subscription wide. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The Client ID (appId) for the Service Principal |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | The Client Secret (password) for the Service Principal used for the AKS deployment |
| <a name="output_name"></a> [name](#output\_name) | Application SP name |
