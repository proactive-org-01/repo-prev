# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-vm-2"
  location = "East US"

  tags = {
    X-CS-Account       = "a77dabbb-bad5-4929-8194-ab32b10b1e6f"
    X-CS-Region        = "eastus"
    X-CS-ResourceGroup = "QA_INFRA_RG"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-vm-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    X-CS-Account       = "a77dabbb-bad5-4929-8194-ab32b10b1e6f"
    X-CS-Region        = "eastus"
    X-CS-ResourceGroup = "QA_INFRA_RG"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
}

# Subnet (does not support tags directly)
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-vm-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "pip" {
  name                = "pip-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"

  tags = {
    X-CS-Account       = "a77dabbb-bad5-4929-8194-ab32b10b1e6f"
    X-CS-Region        = "eastus"
    X-CS-ResourceGroup = "QA_INFRA_RG"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "nic-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    X-CS-Account       = "a77dabbb-bad5-4929-8194-ab32b10b1e6f"
    X-CS-Region        = "eastus"
    X-CS-ResourceGroup = "QA_INFRA_RG"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-ubuntu-demo-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B4ms"
  admin_username      = "azureuser"
  admin_password      = "Eovk_123456"
  disable_password_authentication = false
  

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    X-CS-Account       = "a77dabbb-bad5-4929-8194-ab32b10b1e6f"
    X-CS-Region        = "eastus"
    X-CS-ResourceGroup = "QA_INFRA_RG"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
}	