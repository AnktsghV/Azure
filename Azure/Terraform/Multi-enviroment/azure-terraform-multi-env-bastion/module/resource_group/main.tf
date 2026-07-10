
# Resource Group - Multiple RGs using for_each

resource "azurerm_resource_group" "rg_practical" {
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
}
