variable "rg_win" {
    description = "Creating Resource Group"
    type        = map(any)
}

variable "vnet_wins" {
    description = "Creating Virtual Network of the resource "
    type        = map(any)
}

variable "snet_wins" {
    description = "Creating two subnet using virtual network "
    type        = map(any)
}

variable "pip_wins" {
    description = "Creating Public IP for Virtual Machine"
    type        = map(any)
}

variable "virtual_machine_win" {
    description = "Create Virtual Machine"  
    type        = map(any)   #ye best production partice hai 
}


# TFLint: Yeh ek Quality & Standard Checker hai. 
# Iska kaam yeh batana hai ki aapka code Production-Grade Best Practices follow kar raha hai ya nahi.