module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "default_vnet" {
  source = "../../../modules/azure/default_vnet"

  location                = var.location
  resource_group_name     = module.rg.name
  prefix                  = var.prefix
  label                   = var.label
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_label            = var.subnet_label
  public_ip_sku_name      = var.public_ip_sku_name
  nat_sku_name            = var.nat_sku_name
  zones                   = var.zones
  tags                    = var.tags
}
