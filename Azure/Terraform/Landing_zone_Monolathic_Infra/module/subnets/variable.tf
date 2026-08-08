variable "subnets" {
    description = "Map of Subnets to be created with their configuration details like name, resource group, virtual network name, address prefixes, and optional tags"
    type = map(object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
        address_prefixes     = list(string)
        tags                 = optional(map(string), {})
    }))
  
}