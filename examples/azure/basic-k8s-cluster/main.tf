provider "azurerm" {
  features {}
}

locals {
  prefix   = "basic-k8s-cluster"
  location = "westeurope"
  test = module.vnet.nat_gateway
}

module "rg" {
  source = "../../../modules/azure/rg"

  prefix   = local.prefix
  location = local.location
}

#module "nat-gateway" {
#  source = "../../../modules/nat_gateway"
#
#  resource_group_name     = module.rg.name
#  prefix                  = local.prefix
#  location                = local.location
#  name                    = "no-zone"
#  create_public_ips_count = 1
#}

module "vnet" {
  source = "../../../modules/azure/vnet"

  resource_group_name = module.rg.name
  prefix              = local.prefix
  location            = local.location
  label               = "hub"
  subnets = [
    {
      label                = "main"
      address_prefixes     = ["10.1.1.0/24"]
      create_route_table   = true
      create_nat_gateway   = true
    }
  ]
}



