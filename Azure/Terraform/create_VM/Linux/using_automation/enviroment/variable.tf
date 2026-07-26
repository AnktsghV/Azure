#========= Resource Group Variable ===============
variable "rg-practice" {
  description = "Using harcode to create resource group for Virtual Machine"
}

#========= Virtual_Network_Variable ===============
variable "vnets-prac" {
  description = "To create virtual netowk of virtual machine"
}

#============== Subnets_Variable ===================
variable "snets" {
  description = "Creating Subnets of Virtual machine for practices"
}

#============== Public_IP ===================
variable "public_ips" {
  description = "Public IP to create Virtual Machine"

}

#==============  Virtual_Machine ===================
variable "virtual_macchine" {
  description = "Create Virtual Machine Linux"
}
