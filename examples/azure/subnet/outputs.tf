output "rg" {
  value       = module.rg
  description = "Whole output from 'rg' module."
}

output "subnet" {
  value       = module.subnet
  description = "Whole output from 'subnet' module."
}

output "route_table" {
  value       = var.create_route_table ? module.route_table : null
  description = "Whole output from 'route_table' module."
}

output "default_nat_gateway" {
  value       = var.create_nat_gateway ? module.default_nat_gateway : null
  description = "Whole output from 'default_nat_gateway' module."
}

output "nsg" {
  value       = var.create_nsg ? module.nsg : null
  description = "Whole output from 'nsg' module."
}