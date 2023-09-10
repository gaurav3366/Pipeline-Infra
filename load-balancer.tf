resource "azurerm_public_ip" "pip2" {
  name                = "public-pip"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = "Static"
}

locals {
  frontend_ip_configuration_name = "internal"
}

resource "azurerm_lb" "lb" {
  name                = "lb-rule"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip2.id
  }
}

resource "azurerm_lb_backend_address_pool" "bckndpool" {
  name            = "backend"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "lb-probe" {
  name            = "probe"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "lb-rule" {
  name                           = "http-lb-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  probe_id                       = azurerm_lb_probe.lb-probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bckndpool.id]
  frontend_ip_configuration_name = local.frontend_ip_configuration_name
  protocol                       = "Tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
}