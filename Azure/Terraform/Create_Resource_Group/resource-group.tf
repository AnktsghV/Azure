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
resource "azurerm_resource_group" "terrfirst_resource_group" {
  name     = "first-resource-group"
  location = "eastus"
}