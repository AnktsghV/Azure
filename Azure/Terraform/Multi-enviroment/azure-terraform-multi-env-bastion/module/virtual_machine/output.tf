output "virtual_machines" {
  description = "Virtual machines created in this module"
  value = {
    for k, vm_practical in azurerm_virtual_machine.vm_practical : k => {
      name                  = vm_practical.name
      resource_group_name   = vm_practical.resource_group_name
      location              = vm_practical.location
      network_interface_ids = vm_practical.network_interface_ids
      vm_size               = vm_practical.vm_size
      storage_os_disk       = vm_practical.storage_os_disk
      storage_image         = vm_practical.storage_image_reference
      tags                  = vm_practical.tags
      id                    = vm_practical.id
    }
  }
}