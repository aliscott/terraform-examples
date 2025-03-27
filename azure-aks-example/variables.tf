variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "example-aks-rg"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "aks-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  description = "Names for the subnets"
  type        = list(string)
  default     = ["aks-subnet", "app-subnet"]
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "example-aks"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.25.6"
}

variable "agents_size" {
  description = "Size of the agent VMs"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "agents_min_count" {
  description = "Minimum number of agent nodes"
  type        = number
  default     = 1
}

variable "agents_max_count" {
  description = "Maximum number of agent nodes"
  type        = number
  default     = 3
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "test"
    Project     = "terraform-examples"
    Terraform   = "true"
  }
}
