resource "azurerm_key_vault" "kv" {
  name                        = "terraKVinfra1"
  location                    = "uk south"
  resource_group_name         = "demo-rg1"
  enabled_for_disk_encryption = true
  tenant_id                   = "a8f16248-ee13-4012-992e-7f59ac04718a"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
   
  }
  resource "azurerm_key_vault_secret" "kv_secret" {
  name         = "secret"
  value        = azurerm_container_registry_token.reg-token.name
  key_vault_id = azurerm_key_vault.kv.id
}
