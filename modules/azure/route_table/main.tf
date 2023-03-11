terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_route_table" "rt" {
  name                = "${var.prefix}-${var.label}-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
