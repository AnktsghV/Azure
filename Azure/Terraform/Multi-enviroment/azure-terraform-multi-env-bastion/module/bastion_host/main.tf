resource "azurerm_public_ip" "bastion_public_ip" {
  for_each = var.bastion_hosts

  name = coalesce(each.value.public_ip_name, "${each.value.name}-pip")
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = lookup(each.value, "public_ip_allocation_method", "Static")
  sku                 = lookup(each.value, "public_ip_sku", "Standard")
  tags                = lookup(each.value, "tags", {})
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion_hosts

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = lookup(each.value, "ip_config_name", "configuration")
    subnet_id = var.subnet_ids[each.value.subnet_id]
    public_ip_address_id = azurerm_public_ip.bastion_public_ip[each.key].id
  }

  tags = lookup(each.value, "tags", {})
}
