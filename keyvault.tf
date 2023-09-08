data "azurerm_client_config" "current" {}
/* data "azuread_service_principal" "demo-test-servicep" {
  display_name = "dt-servicep"
} */
resource "azurerm_key_vault" "kv" {
  name                        = "terraKVinfra1"
  location                    = "uk south"
  resource_group_name         = "demo-rg1"
  enabled_for_disk_encryption = true
  tenant_id                   = "a8f16248-ee13-4012-992e-7f59ac04718a"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
      "Release",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set", # Allow setting secrets
      "Backup",
      "Delete",
      "Purge",
      "Recover",
      "Restore"
    ]
  }

}
resource "azurerm_key_vault_secret" "kv_secret" {
  name         = "secret"
  value        = azurerm_container_registry_token.reg-token.name
  key_vault_id = azurerm_key_vault.kv.id
}
