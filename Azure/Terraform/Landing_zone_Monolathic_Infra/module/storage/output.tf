output "storage_accounts_ids" {
    description = "value of storage accounts ids"
    value = { for k, v in azurerm_storage_account.storage_account : k => v.id }
  
}