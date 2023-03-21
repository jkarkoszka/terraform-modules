output "name" {
  description = "Application SP name"
  value       = azuread_application.app.display_name
}

output "object_id" {
  description = "The Service Principal object ID."
  value       = azuread_service_principal.sp.object_id
}

output "client_id" {
  description = "The Client ID (appId) for the Service Principal"
  value       = azuread_application.app.application_id
}

output "client_secret" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  value       = azuread_service_principal_password.sp_password.value
  sensitive   = true
}
