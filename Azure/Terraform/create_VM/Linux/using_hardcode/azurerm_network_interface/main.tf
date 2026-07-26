variable "nics" {
  
}
resource "azurerm_network_interface" "rg-nic" {
    for_each = var.nics
        name                = each.value.name
        location            = each.value.location
        resource_group_name = each.value.resource_group_name
        ip_configuration {  

        }
}
  
