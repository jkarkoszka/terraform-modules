module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-${var.label}-vnet"
  location            = var.location
  resource_group_name = module.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
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
  zone                = var.zone
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

module "subnet" {
  source = "../../../modules/azure/subnet"

  prefix              = var.prefix
  label               = var.label
  location            = var.location
  resource_group_name = module.rg.name
  vnet_name           = azurerm_virtual_network.vnet.name
  address_prefixes    = var.subnet_address_prefixes
  route_table         = var.create_route_table ? {
    resource_group_name = module.route_table[0].resource_group_name
    name                = module.route_table[0].name
  } : null
  nat_gateway = var.create_nat_gateway ? {
    resource_group_name = module.default_nat_gateway[0].nat_gateway.resource_group_name
    name                = module.default_nat_gateway[0].nat_gateway.name
  } : null
  nsg = var.create_nsg ? {
    resource_group_name = module.nsg[0].resource_group_name
    name                = module.nsg[0].name
  } : null
  tags       = var.tags
  depends_on = [module.route_table, module.default_nat_gateway, module.nsg]
}
