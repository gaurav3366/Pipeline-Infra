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
  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
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
  name                       = "vmsss"
  target_resource_id         = azurerm_linux_virtual_machine_scale_set.vmsss.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

  /* enabled_log {
    category = "LinuxSyslog"

  } */

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "primary-db" {
  name                       = "db-logs"
  target_resource_id         = "${azurerm_mssql_server.primary.id}/databases/master"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id

  log {
    category = "SQLSecurityAuditEvents"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [log, metric]
  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "example" {
  database_id            = "${azurerm_mssql_server.primary.id}/databases/master"
  log_monitoring_enabled = true
}

resource "azurerm_mssql_server_extended_auditing_policy" "example" {
  server_id              = azurerm_mssql_server.primary.id
  log_monitoring_enabled = true
}