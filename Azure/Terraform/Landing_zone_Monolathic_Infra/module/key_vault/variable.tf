variable "key_vaults" {
    description = "values for key vaults to be created with their configuration details like name, resource group, location, tenant id, sku name, purge protection enabled and tags"
    type = map(object({
        name                = string
        resource_group_name = string
        location            = string
        tenant_id           = string
        sku_name            = string
        purge_protection_enabled = optional(bool, false)
        tags                = optional(map(string), {})
    }))
  
}