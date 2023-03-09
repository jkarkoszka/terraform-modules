module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "public_ip" {
  source = "../../../modules/azure/public_ip"

  location            = var.location
  resource_group_name = module.rg.name
  prefix              = var.prefix
  label               = var.label
  sku                 = var.sku
  zones               = var.zones
  tags                = var.tags
}
