resource "azurerm_virtual_machine" "vm_practical" {
  for_each              = var.virtual_machines
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = each.value.network_interface_ids
  vm_size               = each.value.vm_size

  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = each.value.os_disk.caching
    create_option     = "FromImage"
    managed_disk_type = each.value.os_disk.storage_account_type
    disk_size_gb      = each.value.os_disk.disk_size_gb
  }

  storage_image_reference {
    publisher = each.value.source_image.publisher
    offer     = each.value.source_image.offer
    sku       = each.value.source_image.sku
    version   = each.value.source_image.version
  }

  os_profile {
    computer_name  = each.value.name
    admin_username = each.value.admin_username
    admin_password = coalesce(each.value.admin_password, "Password1234!#") 
  }
  os_profile_linux_config {
    disable_password_authentication = try(each.value.ssh_public_key_path, null) != null ? true : false
    dynamic "ssh_keys" {
      for_each = try(each.value.ssh_public_key_path, null) != null && try(each.value.ssh_public_key_path, "") != "" ? [1] : []
      content {
        path     = "/home/${each.value.admin_username}/.ssh/authorized_keys"
        key_data = file(each.value.ssh_public_key_path)
      }
    }
  }

  tags = lookup(each.value, "tags", {})
}