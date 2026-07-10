output "network_interfaces" {
  description = "Network interfaces created in this module"
  value = {
    for k, nic_practical in azurerm_network_interface.nic_practical : k => {
      name                = nic_practical.name
      resource_group_name = nic_practical.resource_group_name
      location            = nic_practical.location
      ip_configuration    = nic_practical.ip_configuration
      tags                = nic_practical.tags
      id                  = nic_practical.id
    }
  }
}