variable "lb_rules" {
    description = "values for Load Balancer Rules to be created with their configuration details like name, load balancer id, protocol, port, and optional request path"
    type = map(object({
        name                    = string
        loadbalancer_id         = string
        protocol                = optional(string, null)
        port                    = number
        request_path            = optional(string, null)
        backend_address_pool_ids = optional(list(string), [])
        probe_id                = optional(string, null)
    }))
  
}