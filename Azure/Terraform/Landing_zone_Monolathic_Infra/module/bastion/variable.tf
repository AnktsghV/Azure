variable "bastions" {
    description = "Map of Bastion Hosts to be created with their configuration details like name, location, resource group, subnet id, public ip address id, and optional tags"
    type = map(object({
        name                  = string
        location              = string
        resource_group_name   = string
        subnet_id             = string
        tags                  = optional(map(string), {})
    }))
  
}