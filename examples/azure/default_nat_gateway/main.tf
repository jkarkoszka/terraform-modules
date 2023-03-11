module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "default_nat_gateway" {
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
