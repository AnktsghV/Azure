terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
    features {}
    subscription_id = "9692c062-756e-4f5f-938e-5db71a05ae34"
}
resource "azurerm_resource_group" "rg_storage" {
  name     = "storage-resource-group"
  location = "eastus"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "mystorageaccount123"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}