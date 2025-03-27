provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "Azure/network/azurerm"
  version            = "~> 5.0"
  resource_group_name = azurerm_resource_group.example.name
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names
  tags                = var.tags

  depends_on = [azurerm_resource_group.example]
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  version                          = "~> 6.0"
  resource_group_name              = azurerm_resource_group.example.name
  kubernetes_version               = var.kubernetes_version
  orchestrator_version             = var.kubernetes_version
  prefix                           = var.cluster_name
  cluster_name                     = var.cluster_name
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = 50
  sku_tier                         = "Standard"
  enable_role_based_access_control = true
  rbac_aad_managed                 = true
  private_cluster_enabled          = false
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  enable_host_encryption           = false
  agents_min_count                 = var.agents_min_count
  agents_max_count                 = var.agents_max_count
  agents_count                     = null # Must be null when using auto scaling
  agents_max_pods                  = 100
  agents_pool_name                 = "exnodepool"
  agents_type                      = "VirtualMachineScaleSets"
  agents_size                      = var.agents_size
  tags                             = var.tags

  depends_on = [module.network]
}
