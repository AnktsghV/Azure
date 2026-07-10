resource "azurerm_network_interface" "nic_practical" {
  for_each            = var.network_interfaces
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = var.subnet_ids[each.value.ip_configuration.subnet_id]
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = each.value.ip_configuration.public_ip_address_id
  }

  tags = lookup(each.value, "tags", null)
}