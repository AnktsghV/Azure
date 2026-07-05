resource "azurerm_resource_group" "variable" {
  name     = var.resource_group_name
  location = var.location  
}

resource "azurerm_resource_group" "variable2" {
  name     = var.resource_group_names
  location = var.locations
}