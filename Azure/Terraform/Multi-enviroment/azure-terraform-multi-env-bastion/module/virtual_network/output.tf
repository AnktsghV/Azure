output "vnet_id" {
  description = "Virtual networks created in this module"
  value = {
    for k, vnet_practical in azurerm_virtual_network.vnet_practical : k => vnet_practical.id
  }
}

output "vnet_name" {
  description = "Virtual networks created in this module"
  value = {
    for k, vnet_practical in azurerm_virtual_network.vnet_practical : k => vnet_practical.name
  }
}

output "vnet_location" {
  description = "Virtual networks created in this module"
  value = {
    for k, vnet_practical in azurerm_virtual_network.vnet_practical : k => vnet_practical.location
  }
}

output "vnet_details" {
  description = "Virtual networks created in this module"
  value = {
    for k, vnet_practical in azurerm_virtual_network.vnet_practical : k => {
      name                = vnet_practical.name
      address_space       = vnet_practical.address_space
      location            = vnet_practical.location
      resource_group_name = vnet_practical.resource_group_name
      tags                = vnet_practical.tags
      id                  = vnet_practical.id
    }
  }
}