variable "nsgs" {
    description = "Map of Network Security Groups to be created with their configuration details like name, location, resource group, security rules, and optional tags"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        security_rules      = list(object({
            name                       = string
            priority                   = number
            direction                  = string
            access                     = string
            protocol                   = string
            source_port_range          = string
            destination_port_range     = string
            source_address_prefix      = string
            destination_address_prefix = string
        }))
        tags                = optional(map(string), {})
    }))
  
}