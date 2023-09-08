resource "azurerm_monitor_action_group" "CriticalAlertAction" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.rg2.name
  short_name          = "p0action"

  email_receiver {
    name          = "Gaurav"
    email_address = "gaurav.rai@ve3.global"
  }
}
