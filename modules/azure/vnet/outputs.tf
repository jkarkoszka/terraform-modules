output id {
  value = azurerm_virtual_network.vnet.id
  description = "Azure Virtual Network ID"
}

output name {
  value = azurerm_virtual_network.vnet.name
  description = "Azure Virtual Network name"

}

output "resource_group_name" {
  value       = azurerm_virtual_network.vnet.resource_group_name
  description = "Resource group name"
}

output "subnets" {
  value       = module.subnet[*]
  description = "All outputs from subnet module"
}
