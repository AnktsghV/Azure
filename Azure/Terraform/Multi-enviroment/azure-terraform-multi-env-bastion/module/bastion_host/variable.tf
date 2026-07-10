variable "bastion_hosts" {
  description = "A map of bastion hosts to create"
  type = map(object({
    name                        = string
    resource_group_name         = string
    location                    = string
    subnet_id                   = optional (string)
    ip_config_name              = optional(string, "configuration")
    public_ip_name              = optional(string)
    public_ip_allocation_method = optional(string, "Static")
    public_ip_sku               = optional(string, "Standard")
    tags                        = optional(map(string), {})
  }))
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet names to their Azure resource IDs"
}