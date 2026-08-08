output "nsg_ids" {
    description = "Network security ids"
    value = {for k, v in azurerm_network_security_group.nsg : k => v.id}
}