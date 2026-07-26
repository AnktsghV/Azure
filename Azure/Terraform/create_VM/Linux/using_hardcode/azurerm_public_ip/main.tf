
resource "azurerm_public_ip" "pub_ip_eastus" {
    for_each = var.public_ips
    name = each.value.public_ip_number
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    allocation_method =  each.value.allocation_method
}