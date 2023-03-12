terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-${var.label}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
}

data "azurerm_route_table" "external_rt" {
  count               = var.route_table != null ? 1 : 0
  name                = var.route_table.name
  resource_group_name = var.route_table.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_to_rt" {
  count          = var.route_table != null ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = data.azurerm_route_table.external_rt[count.index].id
}

data "azurerm_nat_gateway" "nat_gateway" {
  count               = var.nat_gateway != null ? 1 : 0
  name                = var.nat_gateway.name
  resource_group_name = var.nat_gateway.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "subnet_to_nat_gateway" {
  count          = var.nat_gateway != null ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway[count.index].id
}

data "azurerm_network_security_group" "nsg" {
  count               = var.nsg != null ? 1 : 0
  name                = var.nsg.name
  resource_group_name = var.nsg.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "subnet_to_nsg" {
  count                     = var.nsg != null ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = data.azurerm_network_security_group.nsg[count.index].id
}
