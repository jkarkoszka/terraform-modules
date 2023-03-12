terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-${var.label}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
  count                       = length(var.nsg_rules)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 100 + 100 * count.index

  name                                       = var.nsg_rules[count.index].name
  direction                                  = var.nsg_rules[count.index].direction
  access                                     = var.nsg_rules[count.index].access
  protocol                                   = var.nsg_rules[count.index].protocol
  description                                = var.nsg_rules[count.index].description
  source_port_range                          = var.nsg_rules[count.index].source_port_range
  source_port_ranges                         = var.nsg_rules[count.index].source_port_ranges
  destination_port_range                     = var.nsg_rules[count.index].destination_port_range
  destination_port_ranges                    = var.nsg_rules[count.index].destination_port_ranges
  source_address_prefix                      = var.nsg_rules[count.index].source_address_prefix
  source_address_prefixes                    = var.nsg_rules[count.index].source_address_prefixes
  source_application_security_group_ids      = var.nsg_rules[count.index].source_application_security_group_ids
  destination_address_prefix                 = var.nsg_rules[count.index].destination_address_prefix
  destination_address_prefixes               = var.nsg_rules[count.index].destination_address_prefixes
  destination_application_security_group_ids = var.nsg_rules[count.index].destination_application_security_group_ids
}
