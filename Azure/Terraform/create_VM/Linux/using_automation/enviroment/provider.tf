terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-practical-eastus"
    storage_account_name = "storagepracticeseastuss"
    container_name       = "practicecontainer"
    key                  = "practice.tfstate"
  }
}

provider "azurerm" {
  features {}

}