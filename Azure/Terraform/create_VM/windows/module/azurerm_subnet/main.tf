resource "azurerm_subnet" "snet_win" {
    for_each = var.snet_wins
    name = each.value.name
    resource_group_name = each.value.resource_group
    virtual_network_name = each.value.vnet_name
    address_prefixes = [each.value.address_prefix]
  
}