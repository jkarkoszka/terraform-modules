output "name" {
  value       = azurerm_route_table.rt.name
  description = "Route table name"
}

output "id" {
  value       = azurerm_route_table.rt.id
  description = "Route table ID"
}

output "resource_group_name" {
  value       = azurerm_route_table.rt.resource_group_name
  description = "Route table resource group name"
}
