output "nic_ids" {
    description = "Map of resource group keys to their created id"
    value = { for k, v in azurerm_network_interface.nic : k => v.id }
  
}