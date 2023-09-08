resource "azurerm_monitor_metric_alert" "aks_cpu_alert" {
  name                = "aks-cpu-alert"
  resource_group_name = azurerm_resource_group.rg2.name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = "AKS CPU Usage Alert"
  severity            = 2 # Warning severity

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.CriticalAlertAction.id
  }

  enabled = true
}


resource "azurerm_monitor_metric_alert" "mssql_database_alert" {
  name                = "mssql-database-query-alert"
  resource_group_name = azurerm_resource_group.rg2.name
  scopes              = [azurerm_mssql_database.primary.id]
  description         = "SQL Database Query Performance Alert"
  severity            = 2 # Warning severity

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.CriticalAlertAction.id
  }

  enabled = true
}
resource "azurerm_monitor_metric_alert" "vmsss-alert" {
  name                = "vmsss-alert"
  resource_group_name = azurerm_resource_group.rg2.name
  scopes              = [azurerm_linux_virtual_machine_scale_set.vmsss.id]
  description         = "Performance"
  severity            = 2 # Warning severity

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.CriticalAlertAction.id
  }

  enabled = true
}