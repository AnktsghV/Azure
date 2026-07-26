#========================= Network Interface Card ================================================#

resource "azurerm_network_interface" "nic_win" {
  for_each            = var.virtual_machine_win
  name                = "nic-${each.value.name}"
  location            = each.value.location
  resource_group_name = each.value.resource_group

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.data_snet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.data_win[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

#========================= Virtual Machine ============================================#

resource "azurerm_windows_virtual_machine" "example" {
  for_each            = var.virtual_machine_win
  name                = each.value.name
  resource_group_name = each.value.resource_group
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic_win[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.os_publisher
    offer     = each.value.os_offer
    sku       = each.value.os_sku
    version   = each.value.os_version
  }
}