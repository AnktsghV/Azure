resource "azurerm_storage_account" "storage_account" {
    for_each = var.storage_accounts

    name                     = each.value.storage_account_name
    resource_group_name      = each.value.resource_group_name
    location                 = each.value.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags                     = lookup(each.value, "tags", {})
}

resource "azurerm_storage_share" "share" {
    for_each = {
    for k, v in var.storage_accounts : k => v
    if lookup(v, "share_name", null) != null
  }

  name                 = each.value.share_name
  storage_account_name = each.value.storage_account_name
  quota                = lookup(each.value, "quota", 50)
  
}