output "vnet" {
  value       = module.vnet
  description = "Whole output from 'vnet' module."
}

output "route_table" {
  value       = module.route_table
  description = "Whole output from 'route_table' module."
}

output "default_nat_gateway" {
  value       = module.default_nat_gateway
  description = "Whole output from 'default_nat_gateway' module."
}

output "nsg" {
  value       = module.nsg
  description = "Whole output from 'nsg' module."
}
