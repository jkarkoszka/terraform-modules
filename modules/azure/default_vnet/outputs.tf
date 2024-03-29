output "vnet" {
  value       = module.vnet
  description = "Whole output from 'vnet' module."
}

output "subnet" {
  value       = module.vnet.subnets[0]
  description = "Whole output from 'subnet' module."
}

output "route_table" {
  value       = module.route_table
  description = "Whole output from 'route_table' module."
}

output "nsg" {
  value       = module.nsg
  description = "Whole output from 'nsg' module."
}
