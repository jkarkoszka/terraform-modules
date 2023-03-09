terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.prefix}-${var.label}-nat-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.nat_sku_name
  zones               = var.zones
  tags                = var.tags
}

data "azurerm_public_ip" "public_ip" {
  count               = length(var.public_ips)
  name                = var.public_ips[count.index].name
  resource_group_name = var.public_ips[count.index].resource_group_name
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  count                = length(var.public_ips)
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = data.azurerm_public_ip.public_ip[count.index].id
}

#module "nat_gateway_public_ip" {
#  count  = var.create_public_ips_count
#  source = "../public_ip"
#
#  prefix              = var.prefix
#  name                = "${var.name}-${count.index}-nat-gateway"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#}
#
