resource "azurerm_redis_cache" "redis-cache" {
  name                = "redis-cache070707"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  capacity            = 2
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"


  redis_configuration {
    //rdb_backup_enabled            = true
    //rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = azurerm_storage_account.blob-storage.primary_blob_connection_string
  }
}
