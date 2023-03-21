output "rg" {
  value       = module.rg
  description = "Whole output from 'rg' module."
}

output "default_aks" {
  value       = module.default_aks
  description = "Whole output from 'default_aks' module."
  sensitive   = true
}
