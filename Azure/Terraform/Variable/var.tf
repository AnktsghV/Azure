variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group Name"
  default     = "RG_Dev"
}
variable "location" {
  type        = string
  description = "Azure Location"
  default     = "East US"
}
variable "resource_group_names" {
  type        = string
  description = "Azure Resource Group Name2"
  default     = "RG_prod"
}
variable "locations" {
  type        = string
  description = "Azure Location"
  default     = "East US"
}
