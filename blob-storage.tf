# Create Azure Blob Storage Account with GRS
resource "azurerm_storage_account" "blob-storage" {
  name                     = "blobstorage070707"
  resource_group_name      = azurerm_resource_group.rg2.name
  location                 = azurerm_resource_group.rg2.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}