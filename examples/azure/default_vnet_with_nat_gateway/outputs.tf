output "rg" {
  value       = module.rg
  description = "Whole output from 'rg' module."
}

output "default_vnet_with_nat_gateway" {
  value       = module.default_vnet_with_nat_gateway
  description = "Whole output from 'default_vnet' module."
}
