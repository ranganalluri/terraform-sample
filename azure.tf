terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    
  }

  required_version = ">= 1.1.0"

   backend "azurerm" {
    resource_group_name = var.bkstrgrg
    storage_account_name = var.bkstrg
    container_name = var.bkcontainer
    key = var.bkstrgkey
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source = "./module/azure_rm_resource"
  rgcount = 1
  rg_name-startswith = "test_ut1"
}

module "test_dv1" {
  source = "./module/azure_rm_resource"
  rgcount = 1
  rg_name-startswith = "test_dv1"

}
# resource "azurerm_resource_group" "rg" {
#   name     = "sss"
#   location = "westus2"
# }

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/22"]
  resource_group_name = module.rg.rg_names[0]
  name                = "myvent"
  depends_on          = [module.rg]
  location            = module.rg.rg_location
}

resource "azurerm_subnet" "subnet" {
  address_prefixes = ["10.0.0.0/24"]
  name = "sub1"
  resource_group_name = module.rg.rg_names[0]
  virtual_network_name = azurerm_virtual_network.vnet.name
}