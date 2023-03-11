module "public_ip" {
  source = "../public_ip"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  sku                 = var.public_ip_sku_name
  zones               = var.zones
  tags                = var.tags
}

module "nat_gateway" {
  source = "../nat_gateway"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  nat_sku_name        = var.nat_sku_name
  zones               = var.zones
  tags                = var.tags
  public_ips          = [
    {
      resource_group_name = module.public_ip.resource_group_name,
      name                = module.public_ip.name
    }
  ]
  depends_on = [module.public_ip]
}
