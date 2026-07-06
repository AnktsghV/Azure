output "resource_group_names" {
  description = "Names of the created resource groups"
  value       = { for k, v in azurerm_resource_group.rg-pratcice-module : k => v.name }
}

output "resource_group_ids" {
  description = "IDs of the created resource groups"
  value       = { for k, v in azurerm_resource_group.rg-pratcice-module : k => v.id }
}
