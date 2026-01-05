resource "azurerm_storage_account" "unencrypted" {
  name                     = "stgaccunencrypted"
  resource_group_name      = "example-rg"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  infrastructure_encryption_enabled = false
}