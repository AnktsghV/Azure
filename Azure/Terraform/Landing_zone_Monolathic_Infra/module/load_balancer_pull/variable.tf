variable "backend_pools" {
    description = "values for backend pools to be created with their configuration details like name, resource group, and load balancer id"
    type = map(object({
        name                = string
        resource_group_name = string
        loadbalancer_id     = string
    }))
}