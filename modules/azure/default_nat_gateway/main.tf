terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

module "public_ip" {
  count  = var.number_of_ip_addresses
  source = "../public_ip"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  sku                 = var.public_ip_sku_name
  zones               = var.zone != null ? [var.zone] : []
  tags                = var.tags
}

module "nat_gateway" {
  source = "../nat_gateway"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  label               = var.label
  nat_sku_name        = var.nat_sku_name
  zone                = var.zone
  tags                = var.tags
  public_ips          = [
    for i in range(length(module.public_ip)) : {
      resource_group_name = module.public_ip[i].resource_group_name,
      name                = module.public_ip[i].name
    }
  ]
  depends_on = [module.public_ip]
}
