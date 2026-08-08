variable "nics" {
    description = "Map of Network Interface Cards to be created with their configuration details like name, location, resource group, virtual network name, subnet name, private IP address, and optional tags"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
        virtual_network_name = string
        subnet_name         = string
        subnet_id           = string
        private_ip_address  = optional(string)
        tags                = optional(map(string), {})
    }))
  
}