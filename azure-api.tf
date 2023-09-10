# Create an Azure API Management Service
resource "azurerm_api_management" "azure-api" {
  name                = "test-apim0707"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  publisher_name      = "My Company"
  publisher_email     = "gaurav.rai@ve3.global"

  sku_name = "Developer_1"
}

# Configure API Gateway to manage AKS APIs
resource "azurerm_api_management_api" "aks_api" {
  name                = "aks-api"
  resource_group_name = azurerm_resource_group.rg2.name
  api_management_name = azurerm_api_management.azure-api.name
  revision            = "1"
  display_name        = "My AKS API"
  path                = "aks"
  import {
    content_format = "swagger-link-json"
    content_value  = "https://your-aks-api-swagger-url/swagger.json"
  }
}

# Create policies for API Gateway (e.g., authentication, rate limiting)
resource "azurerm_api_management_api_policy" "policy" {
  api_management_name = azurerm_api_management.azure-api.name
  resource_group_name = azurerm_resource_group.rg2.name
  api_name            = azurerm_api_management_api.aks_api.name
  xml_content = <<-XML
    <inbound>
      <!-- Add your policies here -->
    </inbound>
    <backend>
      <!-- Add backend policies here -->
    </backend>
    <outbound>
      <!-- Add outbound policies here -->
    </outbound>
    XML
}
