output "secret_ids" {
  description = "Map of secret keys to their Azure Key Vault Secret Resource IDs."
  value       = { for k, v in azurerm_key_vault_secret.kv_secret : k => v.id }
}

output "secret_version_ids" {
  description = "Map of secret keys to their current version IDs."
  value       = { for k, v in azurerm_key_vault_secret.kv_secret : k => v.versionless_id }
}