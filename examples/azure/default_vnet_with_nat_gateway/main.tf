module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "default_vnet_with_nat_gateway" {
  source = "../../../modules/azure/default_vnet_with_nat_gateway"

  location                = var.location
  resource_group_name     = module.rg.name
  prefix                  = var.prefix
  label                   = var.label
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_label            = var.subnet_label
  zone                    = var.zone
  tags                    = var.tags
}
