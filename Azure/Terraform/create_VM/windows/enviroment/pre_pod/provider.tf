terraform {
    required_version = ">= 1.0" 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_win_prac"
    storage_account_name = "storagepracticewin"
    container_name       = "practicecontainer"
    key                  = "practice.tfstate"
  }
}

provider "azurerm" {
  features {}

}