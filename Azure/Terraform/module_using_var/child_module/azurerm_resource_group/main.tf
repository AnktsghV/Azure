variable "resource_group" {}

resource "azurerm_resource_group" "rg_dev_eastus" {
    for_each = var.resource_group
    name     = each.value.name
    location = each.value.location
}