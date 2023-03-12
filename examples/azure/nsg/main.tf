module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "nsg" {
  source = "../../../modules/azure/nsg"

  location            = var.location
  resource_group_name = module.rg.name
  prefix              = var.prefix
  label               = var.label
  nsg_rules           = var.nsg_rules
  tags                = var.tags
}
