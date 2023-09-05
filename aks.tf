resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = "uk south"
  resource_group_name = "demo-rg1"
  dns_prefix          = "demo-aks"

  default_node_pool {
    name       = "node1"
    node_count = 1
    vm_size    = "Standard_B2s"
    enable_auto_scaling         = true
    max_count                   = 3
    min_count                   = 1
    //os_disk_size_gb             = 50
    //type                        = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
  }
}