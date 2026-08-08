output "vm_ids" {
    description = "Map of Virtual Machine keys to their created Resource IDs"
    value = { for k, v in azurerm_linux_virtual_machine.vm : k => v.id }
}   