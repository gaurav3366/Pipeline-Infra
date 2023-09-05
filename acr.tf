resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry17070707"
  resource_group_name = "demo-rg1" //azurerm_resource_group.example.name 
  location            = "uk south" // azurerm_resource_group.example.location
  sku                 = "Standard"
  admin_enabled       = true
}
resource "azurerm_container_registry_scope_map" "scope_map" {
  name                    = "scope-map"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = "demo-rg1"
  actions = [
    "repositories/repo1/content/read",
    "repositories/repo1/content/write"
  ]
}
resource "azurerm_container_registry_token" "reg-token" {
  name                    = "token"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = "demo-rg1"
  scope_map_id            = azurerm_container_registry_scope_map.scope_map.id
}