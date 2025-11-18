resource "azurerm_resource_group" "rg" {
  name     = "rg-sqldb"
  location = "East US"
}

resource "azurerm_mssql_server" "server" {
  name                         = "sqlservercompliant"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  administrator_login           = "sqladmin"
  administrator_login_password  = "StrongPassword123!"
  version                       = "12.0"
}

resource "azurerm_mssql_database" "db" {
  name           = "sqldb-compliant"
  server_id      = azurerm_mssql_server.server.id
  sku_name       = "S0"

  short_term_retention_policy {
    retention_days = 14
  }
}
