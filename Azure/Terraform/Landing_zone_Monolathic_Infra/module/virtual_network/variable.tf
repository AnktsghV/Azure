variable "vnets" {
    description = "Map of Virtual Networks to be created with their configuration details like name, location, resource group, address space, and optional tags"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        address_spaces      = list(string)
        tags                = optional(map(string), {})
    }))
  
}