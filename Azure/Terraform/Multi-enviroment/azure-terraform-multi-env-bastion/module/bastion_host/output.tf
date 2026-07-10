output "bastion_hosts" {
  description = "Bastion hosts created in this module"
  value = {
    for k, bastion_practical in azurerm_bastion_host.bastion : k => {
      name                = bastion_practical.name
      resource_group_name = bastion_practical.resource_group_name
      location            = bastion_practical.location
      dns_name            = bastion_practical.dns_name
      ip_configuration    = bastion_practical.ip_configuration
      tags                = bastion_practical.tags
      id                  = bastion_practical.id
    }
  }
}
