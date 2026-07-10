variable "resource_groups" {
  description = "A map of resource groups to create Production"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
  default = {}
}

variable "subnets" {
  description = "A map of subnets to create Production"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
  default = {}
}

variable "virtual_networks" {
  description = "A map of virtual networks to create Production"
  type = map(object({
    name                = string
    resource_group_name = string
    address_space       = list(string)
    location            = string
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "network_interfaces" {
  description = "A map of network interfaces to create Production"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    # Is block ko introduce kijiye taaki child module ka error khatam ho
    ip_configuration = optional(object({
      name                          = optional(string, "ipconfig1")
      subnet_id                     = string
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip_address_id          = optional(string)
    }))
  }))
  default = {}
}

variable "virtual_machines" {
  description = "A map of virtual machines to create Production"
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    network_interface_ids = list(string)
    vm_size               = string
    admin_username        = string
    admin_password        = string
    ssh_public_key_path   = optional(string, "")
    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    })
    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "bastion_hosts" {
  description = "A map of bastion hosts to create Production"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_id           = string
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "load_balancers" {
  description = "A map of load balancers to create Production"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    frontend_ip_configuration = object({
      name                 = string
      public_ip_address_id = string
    })
    backend_address_pool = object({
      name = string
    })
  }))
  default = {}
}

