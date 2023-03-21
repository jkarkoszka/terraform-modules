output "default_vnet" {
  value       = module.default_vnet
  description = "Whole output from 'default_vnet' module."
}

output "sp_for_aks" {
  value       = module.sp_for_aks
  description = "Whole output from 'sp' module."
  sensitive   = true
}

output "aks" {
  value       = module.aks
  description = "Whole output from 'aks' module."
  sensitive   = true
}
