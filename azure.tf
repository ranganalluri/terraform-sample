terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "sss"
  location = "westus2"
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/22"]
  resource_group_name = azurerm_resource_group.rg.name
  name                = "myvent"
  depends_on          = [azurerm_resource_group.rg]
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_subnet" "subnet" {
  address_prefixes = ["10.0.0.0/24"]
  name = "sub1"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}