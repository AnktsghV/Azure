variable "storage_accounts" {
    description = "Map of Storage Accounts to be created with their configuration details like name, resource group, location, account tier, account replication type, and optional tags"
    type = map(object({
        storage_account_name = string
        share_name           = string
        resource_group_name  = string
        location             = string
    }))
  
}