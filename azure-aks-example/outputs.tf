output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.example.name
}

output "kubernetes_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.aks_name
}

output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster"
  value       = module.aks.client_certificate
  sensitive   = true
}

output "kube_config" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "The Kubernetes cluster server host"
  value       = module.aks.host
  sensitive   = true
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.network.vnet_subnets
}
