output "id" {
  value       = azurerm_subnet.subnet.id
  description = "Subnet ID"
}

output "name" {
  value       = azurerm_subnet.subnet.name
  description = "Subnet name"
}

output "resource_group_name" {
  value       = azurerm_subnet.subnet.resource_group_name
  description = "Resource group name"
}

output "vnet_name" {
  value       = azurerm_subnet.subnet.virtual_network_name
  description = "Virtual network name"
}

output "address_prefixes" {
  value       = azurerm_subnet.subnet.address_prefixes
  description = "The address prefixes to use for the subnet."
}
