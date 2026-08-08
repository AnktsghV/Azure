output "resource_group_names" {
    description = "Map of resource group keys to their created names"
    value = { for k, v in azurerm_resource_group.rg_prac : k => v.name }
}

output "resource_group_location" {
    description = "Map of resource group keys to their created primary location"
    value       = { for k, v in azurerm_resource_group.rg_prac : k => v.location }
}
