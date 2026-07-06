resource "azurerm_resource_group" "example" {
  name     = "rg-output-demo"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "stoutputdemo12345"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
