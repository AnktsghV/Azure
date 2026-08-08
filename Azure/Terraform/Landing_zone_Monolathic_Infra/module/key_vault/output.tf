output "key_vault_ids" {
    description = "values for key vaults to be created with their configuration details like name, resource group, and location"
    value = {for k, v in azurerm_key_vault.key_vault : k => v.id }
  
}