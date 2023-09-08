# Generate a random password for SQL Server
resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
# Store SQL Server password in KeyVault
resource "azurerm_key_vault_secret" "sql_password_secret" {
  name         = "sql-server-password"
  value        = random_password.sql_password.result
  key_vault_id = azurerm_key_vault.kv.id
}
# Create Azure SQL Server
resource "azurerm_mssql_server" "primary" {
  name                         = "primary-sql-server"
  resource_group_name          = azurerm_resource_group.rg2.name
  location                     = azurerm_resource_group.rg2.location
  version                      = "12.0"
  administrator_login          = "mssqladmin"
  administrator_login_password = random_password.sql_password.result
}
# Create Azure SQL Database
resource "azurerm_mssql_database" "primary" {
  name      = "primary-sql-db"
  server_id = azurerm_mssql_server.primary.id
  #sku_name            = "P2"
}
# Create a secondary SQL Server in another location for Geo-Replication
resource "azurerm_mssql_server" "secondary" {
  name                         = "mssql-server-secondary"
  resource_group_name          = azurerm_resource_group.rg2.name
  location                     = "West US" # Replace with your desired secondary location
  version                      = "12.0"
  administrator_login          = "mssqladmin"
  administrator_login_password = random_password.sql_password_secondary.result
}

# Generate a random password for the secondary SQL Server
resource "random_password" "sql_password_secondary" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Store the secondary SQL Server password in KeyVault
resource "azurerm_key_vault_secret" "sql_password_secondary_secret" {
  name         = "mssql-server-secondary-password"
  value        = random_password.sql_password_secondary.result
  key_vault_id = azurerm_key_vault.kv.id
}
# For Failover Geo Replcation
resource "azurerm_mssql_failover_group" "geo" {
  name      = "failover0707"
  server_id = azurerm_mssql_server.primary.id
  databases = [
    azurerm_mssql_database.primary.id
  ]

  partner_server {
    id = azurerm_mssql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 80
  }

  tags = {
    environment = "prod"
    database    = "example"
  }
}
output "sql_server_name" {
  value = azurerm_mssql_server.primary.name
}

output "database_name" {
  value = azurerm_mssql_database.primary.name
}
