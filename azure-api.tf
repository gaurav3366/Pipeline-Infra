resource "azurerm_api_management" "azure-api" {
  name                = "test-apim0707"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  publisher_name      = "My Company"
  publisher_email     = "gaurav.rai@ve3.global"

  sku_name = "Developer_1"
}