output "resource_group_names" {
  description = "Resource group names created by the parent module"
  value       = module.resource_group.resource_group_names
}

output "virtual_network_ids" {
  description = "Virtual network IDs created by the parent module"
  value       = module.virtual_network.virtual_network_ids
}

output "subnet_ids" {
  description = "Subnet IDs created by the parent module"
  value       = module.subnet.subnet_ids
}
