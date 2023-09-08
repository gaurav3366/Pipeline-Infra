resource "azurerm_mssql_firewall_rule" "aks_firewall_rule" {
  name             = "aks-firewall-rule"
  server_id        = azurerm_mssql_server.primary.id
  start_ip_address = "10.0.1.0"   # AKS subnet address
  end_ip_address   = "10.0.1.255" # AKS subnet address range
}
