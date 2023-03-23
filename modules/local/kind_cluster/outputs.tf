output "name" {
  value       = kind_cluster.cluster.name
  description = "The name of the cluster."
}

output "host" {
  value       = kind_cluster.cluster.endpoint
  description = "The endpoint for your Kubernetes API server."
}

output "client_certificate" {
  value       = base64encode(kind_cluster.cluster.client_certificate)
  sensitive   = true
  description = "Client certificate for authenticating to cluster."
}

output "client_key" {
  value       = base64encode(kind_cluster.cluster.client_key)
  sensitive   = true
  description = " Client key for authenticating to cluster."
}

output "cluster_ca_certificate" {
  value       = base64encode(kind_cluster.cluster.cluster_ca_certificate)
  sensitive   = true
  description = "The base64 encoded certificate data required to communicate with your cluster. Add this to the certificate-authority-data section of the kubeconfig file for your cluster."
}

output "kubeconfig" {
  value       = base64encode(kind_cluster.cluster.kubeconfig)
  sensitive   = true
  description = "The kubeconfig for the cluster after it is created"
}
