output "resource_groups_name" {                                             # Resource Groups ke Naam ko collect karke dikhata hai
    description = "Resource groups created in this module"
    value = {                                                                                   #too shoow out data in key value pair format
    for k, rg_practical in azurerm_resource_group.rg_practical : k => rg_practical.name 
         }

}

output "resource_groups_id" {
    description = "Resource groups created in this module"
    value = { 
    for k, rg_practical in azurerm_resource_group.rg_practical : k => rg_practical.id 
         }

}

output "resource_groups_location" {
    description = "Resource groups created in this module"
    value = { 
    for k, rg_practical in azurerm_resource_group.rg_practical : k => rg_practical.location 
         }

}

output "resource_groups" {
    description = "Resource groups created in this module"
    value = { 
    for k, rg_practical in azurerm_resource_group.rg_practical : k => {
        name     = rg_practical.name
        location = rg_practical.location
        id       = rg_practical.id
    }
         }
}