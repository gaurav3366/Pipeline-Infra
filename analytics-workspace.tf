resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "Infra-log-analytics"
  location            = "uk south"
  resource_group_name = azurerm_resource_group.rg2.name
  sku                 = "PerGB2018"
}

resource "azurerm_monitor_diagnostic_setting" "aks_diagnostic" {
  name                       = "Infra-aks-diagnostic"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

  enabled_log {
    category = "kube-apiserver"

    retention_policy {
      enabled = false
      days    = 0
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
  # Configure additional logs and metrics as needed
}
/* resource "azurerm_monitor_diagnostic_setting" "mssqlserver_diagnostic" {
  name                       = "mssql-server-diagnostic"
  target_resource_id         = azurerm_mssql_server.primary.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

  enabled_log {
    category = "SQLSecurityAuditEvents"

    retention_policy {
      enabled = false
      days    = 0
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
  # Configure additional logs and metrics as needed
} */


/* resource "azurerm_monitor_diagnostic_setting" "database_diagnostic" {
  name = "msdb-database-diagnostic"
  //database_name              = azurerm_mssql_database.primary.name
  target_resource_id         = azurerm_mssql_database.primary.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

    log {
    category = "SQLSecurityAuditEvents"
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
  # Configure additional logs and metrics as needed
}

resource "azurerm_monitor_diagnostic_setting" "vmsss" {
  name               = "vmsss"
  target_resource_id = azurerm_linux_virtual_machine_scale_set.vmsss.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

    enabled_log{
    category = "AuditEvent"

  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
} */
