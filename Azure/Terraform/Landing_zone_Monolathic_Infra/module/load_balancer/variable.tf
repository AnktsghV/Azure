variable "load_balancers" {
    description = "Map of Load Balancers to be created with their configuration details like name, location, resource group, and optional tags"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
    }))
  
}