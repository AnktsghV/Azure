resource "azurerm_resource_group" "rg-practical-eastus" {
  for_each = var.rg-practice
  name     = each.value.name
  location = each.value.location
}