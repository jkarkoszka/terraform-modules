output "public_ips" {
  value       = module.public_ip
  description = "List of whole outputs from 'public_ip' module."
}

output "nat_gateway" {
  value       = module.nat_gateway
  description = "Whole output from 'nat_gateway' module."
}
