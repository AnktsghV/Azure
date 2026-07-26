#=========================== Subnet ===============================#

data "azurerm_subnet" "data_subnet" {
    for_each = var.virtual_macchine
    name = each.value.nic_subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.rg_name
}

#=========================== PublicIP ===============================#

data "azurerm_public_ip" "data_public_ip" {
    for_each = var.virtual_macchine
    name = each.value.nic_pip_name
    resource_group_name = each.value.rg_name
  
}