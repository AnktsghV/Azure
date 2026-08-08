variable "vms" {
    description = "Map of Virtual Machines to be created with their configuration details like name, location, resource group, network interface ids, vm size, admin username, admin password, disabled password authentication, os disk caching, os disk storage account type, source image reference publisher, source image reference offer, source image reference sku, source image reference version, and optional tags"
    type = map(object({
        name                            = string
        location                        = string
        resource_group_name             = string
        network_interface_ids           = list(string)
        vm_size                         = string
        admin_username                  = string
        admin_password                  = string
        disabled_password_authentication = bool
        os_disk_caching                 = string
        os_disk_storage_account_type    = string
        source_image_reference_publisher = string
        source_image_reference_offer     = string
        source_image_reference_sku       = string
        source_image_reference_version   = string
        tags                            = optional(map(string), {})
    }))
  
}