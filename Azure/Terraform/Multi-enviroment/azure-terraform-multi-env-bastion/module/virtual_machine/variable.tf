variable "virtual_machines" {
  description = "A map of virtual machines to create"
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
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
    tags                    = optional(map(string), {})
  }))
}
