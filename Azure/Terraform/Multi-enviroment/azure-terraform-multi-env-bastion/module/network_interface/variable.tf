variable "network_interfaces" {
  description = "A map of network interfaces to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    ip_configuration = object({
      name                          = optional(string, "ipconfig1")
      subnet_id                     = string  
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip_address_id          = optional(string, null)
    })
  }))
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet names to their Azure resource IDs"
}