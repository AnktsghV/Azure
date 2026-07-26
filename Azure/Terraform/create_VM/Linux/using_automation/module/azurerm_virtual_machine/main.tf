variable "virtual_macchine" { }

#========================= Network Interface Card ================================================#

resource "azurerm_network_interface" "rg-nic" {
    for_each = var.virtual_macchine
        name                = each.value.nic_name
        location            = each.value.location
        resource_group_name = each.value.rg_name
        ip_configuration {  
            name = "Dhondu"
            subnet_id                     = data.azurerm_subnet.data_subnet[each.key].id 
            public_ip_address_id          = data.azurerm_public_ip.data_public_ip[each.key].id 
            private_ip_address_allocation = "Dynamic"
            }
}
  #========================= Virtual Machine ================================================#
resource "azurerm_linux_virtual_machine" "vm_rg_pratice" {
    for_each = var.virtual_macchine
    name = each.value.vm_name
    resource_group_name = each.value.rg_name
    location = each.value.location
    size = each.value.vm_size
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
    disable_password_authentication = false
    network_interface_ids = [ azurerm_network_interface.rg-nic[each.key].id ]
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
        }
    source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
    }
}