terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-${var.label}-rg"
  location = var.location
  tags     = var.tags
}
