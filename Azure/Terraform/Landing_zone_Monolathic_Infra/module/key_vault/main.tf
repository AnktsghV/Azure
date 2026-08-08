resource "azurerm_key_vault" "key_vault" {
    for_each = var.key_vaults
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    tenant_id           = each.value.tenant_id
    sku_name            = each.value.sku_name
    purge_protection_enabled = lookup(each.value, "purge_protection_enabled", false)
    tags = lookup(each.value, "tags", {})
  
}