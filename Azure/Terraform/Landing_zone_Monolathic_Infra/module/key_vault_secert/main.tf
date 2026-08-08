resource "azurerm_key_vault_secret" "kv_secret" {
    for_each = var.key_vault_secrets
        name            = "${each.value.name}"
        value           = "${each.value.value}"
        key_vault_id    = each.value.key_vault_id
  
}