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

output "nat_gateway_id" {
  value       = local.nat_gateway_id
  description = "NAT Gateway ID"
}

output "nat_gateway_name" {
  value       = local.nat_gateway_name
  description = "NAT Gateway name"
}

output "nat_gateway_resource_group_name" {
  value       = local.nat_gateway_rg
  description = "NAT Gateway Resource group name"
}

output nat_gateway {
  value = module.new_nat_gateway
}

// same for route table
//and then output in vnet