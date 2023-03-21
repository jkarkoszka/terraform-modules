terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.36"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

locals {
  scopes = length(var.scopes) > 0 ? var.scopes : [data.azurerm_subscription.current.id]
}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "main" {
  count = var.role != "" ? 1 : 0
  name  = var.role
  scope = data.azurerm_subscription.current.id
}

resource "azuread_application" "app" {
  display_name = "${var.prefix}-${var.label}-sp"
  owners       = [data.azuread_client_config.current.object_id]
}

#
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id
  owners         = [data.azuread_client_config.current.object_id]
}

resource "time_rotating" "tr" {
  rotation_days = 7
}

resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.sp.object_id
  rotate_when_changed  = {
    rotation = time_rotating.tr.id
  }
}

resource "azurerm_role_assignment" "main" {
  count                            = var.role != "" ? length(local.scopes) : 0
  scope                            = local.scopes[count.index]
  role_definition_id               = data.azurerm_role_definition.main[0].id
  principal_id                     = azuread_service_principal.sp.object_id
  skip_service_principal_aad_check = true
}

resource "time_sleep" "wait_for_aad_propagation" {
  depends_on = [azurerm_role_assignment.main]

  create_duration = "60s"
}
