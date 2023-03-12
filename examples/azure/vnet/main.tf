module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "default_nat_gateway" {
  count  = var.create_nat_gateway ? 1 : 0
  source = "../../../modules/azure/default_nat_gateway"

  location            = var.location
  resource_group_name = module.rg.name
  prefix              = var.prefix
  label               = var.label
  nat_sku_name        = var.nat_sku_name
  public_ip_sku_name  = var.public_ip_sku_name
  zones               = var.zones
  tags                = var.tags
}

module "route_table" {
  count  = var.create_route_table ? 1 : 0
  source = "../../../modules/azure/route_table"

  location            = var.location
  resource_group_name = module.rg.name
  prefix              = var.prefix
  label               = var.label
  tags                = var.tags
}

module "nsg" {
  count  = var.create_nsg ? 1 : 0
  source = "../../../modules/azure/nsg"

  location            = var.location
  resource_group_name = module.rg.name
  prefix              = var.prefix
  label               = var.label
  tags                = var.tags
}

module "vnet" {
  source = "../../../modules/azure/vnet"

  prefix              = var.prefix
  label               = var.label
  location            = var.location
  resource_group_name = module.rg.name
  vnet_address_space  = var.vnet_address_space
  subnets             = var.subnets
  tags                = var.tags
  depends_on          = [module.route_table, module.default_nat_gateway, module.nsg]
}
