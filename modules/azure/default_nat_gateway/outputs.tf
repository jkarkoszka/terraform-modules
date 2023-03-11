output "public_ip" {
  value       = module.public_ip
  description = "Whole output from 'public_ip' module."
}

output "nat_gateway" {
  value       = module.nat_gateway
  description = "Whole output from 'nat_gateway' module."
}
