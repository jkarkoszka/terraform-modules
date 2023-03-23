output "id" {
  value       = azurerm_nat_gateway.nat_gateway.id
  description = "NAT Gateway ID"
}

output "name" {
  value       = azurerm_nat_gateway.nat_gateway.name
  description = "NAT Gateway name."
}

output "resource_group_name" {
  value       = azurerm_nat_gateway.nat_gateway.resource_group_name
  description = "Resource group name."
}

output "public_ip_addresses" {
  value = data.azurerm_public_ip.public_ip[*].ip_address
  description = "NAT Gateway Public IPs."
}

output "public_ip_ids" {
  value = data.azurerm_public_ip.public_ip[*].id
  description = "NAT Gateway Public IPs IDs."
}