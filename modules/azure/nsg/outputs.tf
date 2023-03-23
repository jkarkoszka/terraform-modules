output "id" {
  value       = azurerm_network_security_group.nsg.id
  description = "Network Security Group ID."
}

output "name" {
  value       = azurerm_network_security_group.nsg.name
  description = "Network Security Group name."
}

output "resource_group_name" {
  value       = azurerm_network_security_group.nsg.resource_group_name
  description = "Resource group name."
}
