terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-${var.label}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.sku
  zones               = var.zones
  tags                = var.tags
}
