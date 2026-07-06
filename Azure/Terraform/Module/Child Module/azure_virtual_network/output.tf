output "virtual_network_names" {
  description = "Names of the created virtual networks"
  value       = { for k, v in azurerm_virtual_network.vnet-pratcice-module : k => v.name }
}

output "virtual_network_ids" {
  description = "IDs of the created virtual networks"
  value       = { for k, v in azurerm_virtual_network.vnet-pratcice-module : k => v.id }
}
