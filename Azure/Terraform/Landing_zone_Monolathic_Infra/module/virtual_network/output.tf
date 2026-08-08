output "vnets" {
    description = "Map containing all created Virtual Network details indexed by key"
    value = azurerm_virtual_network.vnet
}

output "vnets_names" {
    description = "Map containing all created Virtual Network names indexed by key"
    value = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}

output "vnets_id" {
    description = "Map of Virtual Network keys to their created Resource IDs"
    value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}