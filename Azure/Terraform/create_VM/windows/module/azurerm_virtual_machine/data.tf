data "azurerm_subnet" "data_snet" {
  for_each             = var.virtual_machine_win
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group
}

data "azurerm_public_ip" "data_win" {
  for_each            = var.virtual_machine_win
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group
}