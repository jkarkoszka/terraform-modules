output "rg" {
  value       = module.rg
  description = "Whole output from 'rg' module."
}

output "vnet" {
  value       = module.vnet
  description = "Whole output from 'vnet' module."
}

output "route_table" {
  value       = var.create_route_table ? module.route_table[0] : null
  description = "Whole output from 'route_table' module."
}

output "default_nat_gateway" {
  value       = var.create_nat_gateway ? module.default_nat_gateway[0] : null
  description = "Whole output from 'default_nat_gateway' module."
}

output "nsg" {
  value       = var.create_nsg ? module.nsg[0] : null
  description = "Whole output from 'nsg' module."
}
