terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

locals {
  vnet_name                       = "${var.prefix}-${var.label}-vnet"
  subnet_prefix                   = local.vnet_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

module "subnet" {
  count  = length(var.subnets)
  source = "../vnet_subnet"

  prefix               = local.subnet_prefix
  label                = var.subnets[count.index].label
  location             = var.location
  resource_group_name  = var.resource_group_name
  vnet_name            = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets[count.index].address_prefixes
  external_route_table = var.subnets[count.index].external_route_table
  create_route_table   = var.subnets[count.index].create_route_table
  tags                 = var.tags
}
