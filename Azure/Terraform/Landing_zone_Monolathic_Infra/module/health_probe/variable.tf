variable "health_probes" {
    description = "Map of Health Probes to be created with their configuration details like name, load balancer id, protocol, port, and optional request path"
    type = map(object({
        name                = string
        loadbalancer_id     = string
        protocol            = optional(string, null)
        port                = number
        request_path        = optional(string, null)
    }))
  
}