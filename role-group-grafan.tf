# Define the role assignment
resource "azurerm_role_assignment" "rbac" {
  principal_id         = azurerm_dashboard_grafana.grafana-dash.identity.0.principal_id # The ID of the user, group, or service principal
  role_definition_name = "Reader"                                                       # The name of the role you want to assign (e.g., "Reader")
  scope                = azurerm_monitor_workspace.amw.id                               # The scope at which the role assignment applies
}