resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  dns_prefix          = "demo-aks"

  default_node_pool {
    name                = "node1"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
    // redis_resource_id = azurerm_redis_cache.redis-cache.id
    //os_disk_size_gb             = 50
    //type                        = "VirtualMachineScaleSets"

  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.0.0.0/16"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
  }
}
  /* kube_dashboard {
      enabled = false
      redis_resource_id = azurerm_redis_cache.redis-cache.id
    } */

  /* # Enable Azure Redis Cache integration
    azure_redis_cache {
      enabled = true
      redis_resource_id = azurerm_redis_cache.redis-cache.id
  } */
