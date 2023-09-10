# Create Azure Traffic Manager Profile

/* resource "azurerm_public_ip" "public-ip1" {
  name                = "test-public-ip1"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = "Static"
  domain_name_label   = "test-public-ip1"
} */
resource "azurerm_traffic_manager_profile" "tr-manager" {
  name                   = "terraform07-traffic-manager"
  resource_group_name    = azurerm_resource_group.rg2.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = "example"
    ttl           = 60
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  profile_status = "Enabled"
}