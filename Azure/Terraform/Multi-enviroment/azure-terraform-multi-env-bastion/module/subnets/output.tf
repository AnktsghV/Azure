output "subnet_ids" {
    description = "Subnets created in this module"
    value = { 
    for k, snet_practical in azurerm_subnet.snet_practical : k => snet_practical.id 
         }

}

output "subnet_names" {
    description = "Subnets created in this module"
    value = { 
    for k, snet_practical in azurerm_subnet.snet_practical : k => snet_practical.name 
         }

}

output "subnet_details" {
    description = "Subnets created in this module"
    value = { 
    for k, snet_practical in azurerm_subnet.snet_practical : k => {
        name                 = snet_practical.name
        resource_group_name  = snet_practical.resource_group_name
        virtual_network_name = snet_practical.virtual_network_name
        address_prefixes     = snet_practical.address_prefixes
        id                   = snet_practical.id
    }
         }
}
