resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = "uk south"
  resource_group_name = "demo-rg1"
  dns_prefix          = "demo-aks"

  default_node_pool {
    name                = "node1"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
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