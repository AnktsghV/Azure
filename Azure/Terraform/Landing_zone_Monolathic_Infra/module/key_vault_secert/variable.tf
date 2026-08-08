variable  "key_vault_secrets" {
    description = "values for key vault secrets to be created with their configuration details like name, value, and key vault id"
    type = map(object({
        name          = string
        value         = string
        key_vault_id  = string
    }))
  
}