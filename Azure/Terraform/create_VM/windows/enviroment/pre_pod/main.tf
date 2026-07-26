module "resource_group" {
    source = "../../module/azurerm_resource_group"
    rg_win = var.rg_win
}

module "virtual_network" {
    depends_on = [ module.resource_group ]
    source = "../../module/azurerm_virtual_network"
    vnet_wins = var.vnet_wins  
}

module "subnets" {
    depends_on = [ module.virtual_network ]
    source = "../../module/azurerm_subnet"
    snet_wins = var.snet_wins 
}

module "public_ip" {
    depends_on = [ module.resource_group ]
    source = "../../module/azurerm_public_ip"
    pip_wins = var.pip_wins
}

module "virtual_machine" {
    depends_on = [ module.subnets, module.public_ip ]
    source = "../../module/azurerm_virtual_machine"
    virtual_machine_win = var.virtual_machine_win
  
}