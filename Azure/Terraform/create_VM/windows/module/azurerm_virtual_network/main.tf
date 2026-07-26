resource "azurerm_virtual_network" "vnet_win" {
    for_each = var.vnet_wins
    name   = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group
    address_space = each.value.address_space
  
}