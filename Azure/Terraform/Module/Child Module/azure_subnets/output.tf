output "subnet_names" {
  description = "Names of the created subnets"
  value       = { for k, v in azurerm_subnet.subnet-pratcice-module : k => v.name }
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = { for k, v in azurerm_subnet.subnet-pratcice-module : k => v.id }
}
