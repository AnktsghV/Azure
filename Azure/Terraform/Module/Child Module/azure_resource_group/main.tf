variable "resource_groups" {}

resource "azurerm_resource_group" "rg-pratcice-module" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
  
}