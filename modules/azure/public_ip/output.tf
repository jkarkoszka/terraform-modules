output "id" {
  value       = azurerm_public_ip.public_ip.id
  description = "Public IP ID"
}

output "ip_address" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "Public IP"
}

output "name" {
  value       = azurerm_public_ip.public_ip.name
  description = "Public IP name"
}

output "resource_group_name" {
  value       = azurerm_public_ip.public_ip.resource_group_name
  description = "Resource group name"
}