resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms

  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = each.value.vm_size 
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = lookup(each.value, "disable_password_authentication", false) 

  network_interface_ids = each.value.network_interface_ids 

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference_publisher
    offer     = each.value.source_image_reference_offer
    sku       = each.value.source_image_reference_sku
    version   = each.value.source_image_reference_version
  }

  tags = lookup(each.value, "tags", {})
}
