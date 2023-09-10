# Create Azure Traffic Manager Profile
resource "azurerm_public_ip" "public-ip" {
  name                = "test-public-ip2"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = "Static"
  domain_name_label   = "test-public-ip"
}
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "aks-vnet"
  location            = "uk south"
  resource_group_name = azurerm_resource_group.rg2.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location

  ip_configuration {
    name                          = azurerm_public_ip.public-ip.name
    subnet_id                     = azurerm_subnet.aks_subnet.id
    private_ip_address_allocation = "Dynamic"
    //public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}
