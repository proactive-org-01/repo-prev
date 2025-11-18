resource "azurerm_resource_group" "rg" {
  name     = "rg-sqlmi"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-sqlmi"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-sqlmi"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  delegation {
    name = "managedinstancedelegation"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# ❌ Managed Instance created without any database attached
resource "azurerm_mssql_managed_instance" "mi" {
  name                         = "sqlmi-noncompliant"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  administrator_login           = "sqladmin"
  administrator_login_password  = "Password123!"
  sku_name                      = "GP_Gen5"
  subnet_id                     = azurerm_subnet.subnet.id
  storage_size_in_gb            = 256
  vcores                        = 4
  license_type                  = "BasePrice"
  databases_attached          = false
}
