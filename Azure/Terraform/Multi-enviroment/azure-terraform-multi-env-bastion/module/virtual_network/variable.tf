variable "virtual_networks" {
  description = "A map of virtual networks to create"
  type = map(object({
    name                = string
    resource_group_name = string
    address_space       = list(string)
    location            = string
    tags                = optional(map(string), {})
  }))
}
