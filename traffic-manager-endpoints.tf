/* # Create the Azure Traffic Manager endpoint for the VMSS
resource "azurerm_traffic_manager_azure_endpoint" "vmss_endpoint" {
  name                = "vmss-endpoint"
  profile_name        = azurerm_traffic_manager_profile.tr-manager.name
  resource_group_name = azurerm_resource_group.rg2.name
  type                = "azureEndpoints"
  target_resource_id = azurerm_linux_virtual_machine_scale_set.example.id
  for_each = azurerm_linux_virtual_machine_scale_set.example.virtual_machine{
    weight = 1
    endpoint_status = "Enabled"
  }
} */


# Update the Traffic Manager endpoint
/* resource "azurerm_traffic_manager_azure_endpoint" "endpoint" {
  //for_each            = azurerm_linux_virtual_machine_scale_set.vmsss
  name               = "test-endpoint"
  profile_id         = azurerm_traffic_manager_profile.tr-manager.id
  target_resource_id = azurerm_public_ip.public-ip.id
  weight             = 2
} */
/* resource "azurerm_traffic_manager_azure_endpoint" "aks_endpoint" {
  name               = "aks-endpoint"
  profile_id         = azurerm_traffic_manager_profile.tr-manager.id
  target_resource_id = azurerm_kubernetes_cluster.aks.id
  weight             = 50
} */

resource "azurerm_traffic_manager_azure_endpoint" "vmss_endpoint" {
  name               = "vmss-endpoint"
  profile_id         = azurerm_traffic_manager_profile.tr-manager.id
  target_resource_id = azurerm_public_ip.public-ip.id
  weight             = 50
}