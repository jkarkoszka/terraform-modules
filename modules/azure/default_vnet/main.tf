terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

module "default_nat_gateway" {
  source = "../../../modules/azure/default_nat_gateway"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  zone                = var.zone
  tags                = var.tags
}

module "route_table" {
  source = "../../../modules/azure/route_table"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  tags                = var.tags
}

module "nsg" {
  source = "../../../modules/azure/nsg"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  tags                = var.tags
}

module "vnet" {
  source = "../../../modules/azure/vnet"

  prefix              = var.prefix
  label               = var.label
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_address_space  = var.vnet_address_space
  subnets             = [
    {
      label            = var.subnet_label
      address_prefixes = var.subnet_address_prefixes
      route_table      = {
        resource_group_name = var.resource_group_name
        name                = module.route_table.name
      }
      nat_gateway = {
        resource_group_name = var.resource_group_name
        name                = module.default_nat_gateway.nat_gateway.name
      }
      nsg = {
        resource_group_name = var.resource_group_name
        name                = module.nsg.name
      }
    }
  ]
  tags       = var.tags
  depends_on = [module.route_table, module.default_nat_gateway, module.nsg]
}
