output "bastions_ids" {
    description = "values for bastions to be created with their configuration details like name, resource group, and location"
    value = {for k, v in azurerm_bastion_host.bastion : k => v.id }
  
}