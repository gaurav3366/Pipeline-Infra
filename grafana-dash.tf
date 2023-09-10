resource "azurerm_dashboard_grafana" "grafana-dash" {
  name                              = "grafana-dg"
  resource_group_name               = azurerm_resource_group.rg2.name
  location                          = azurerm_resource_group.rg2.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = false

  identity {
    type = "SystemAssigned"
  }
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.amw.id
  }

  tags = {
    key = "value"
  }
}