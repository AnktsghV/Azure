# dev ka variable hai

variable "resource_groups" {
  description = "A map of resource groups for configuration"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "virtual_networks" {
  description = "A map of virtual networks for configuration"
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
    tags                = map(string)
  }))
}

variable "subnets" {
  description = "A map of subnets for configuration"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "virtual_machines" {
  description = "A map of virtual machines for configuration"
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = list(string)
    vm_size               = string
    admin_username        = string
    admin_password        = string
    ssh_key               = optional(string, "")
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
    data_disks = optional(list(object({
      lun                  = number
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    })), [])
    enable_boot_diagnostics = optional(bool, true)
    tags                    = map(string)
  }))
  default = {}
}

variable "network_interfaces" {
  description = "A map of network interfaces for configuration"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    ip_configuration = object({
      name                          = optional(string, "ipconfig1")
      subnet_id                     = string
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip_address_id          = optional(string, null)
    })
    
    tags = optional(map(string), {})
  }))
}

variable "bastion_hosts" {
  description = "A map of bastion hosts for configuration"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_id           = string
    tags                = optional(map(string), {})
  }))
}