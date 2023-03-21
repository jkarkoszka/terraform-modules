output "name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the cluster."
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  description = "The endpoint for your Kubernetes API server."
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
  description = "Client certificate for authenticating to cluster."
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
  description = " Client key for authenticating to cluster."
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
  description = "The base64 encoded certificate data required to communicate with your cluster. Add this to the certificate-authority-data section of the kubeconfig file for your cluster."
}

output "kubeconfig" {
  value       = base64encode(azurerm_kubernetes_cluster.aks.kube_config_raw)
  sensitive   = true
  description = "The kubeconfig for the cluster after it is created"
}
