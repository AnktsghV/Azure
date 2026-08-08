resource "azurerm_public_ip" "pip_bastion" {
    for_each = var.bastions

    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    allocation_method   = "Static"
    sku                 = "Standard"
  
}

resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastions
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    tunneling_enabled   = false
    ip_connect_enabled  = true
    shareable_link_enabled = false
    ip_configuration {
        name = "configuration"
        subnet_id = each.value.subnet_id
        public_ip_address_id = azurerm_public_ip.pip_bastion[each.key].id
    }
}