#================= Production Environment =================

# ================ Resource Group =================
module "resource_group" {
  source          = "../../module/resource_group"
  resource_groups = var.resource_groups
}

# ================ Virtual Network =================
module "virtual_network" {
  depends_on       = [module.resource_group]
  source           = "../../module/virtual_network"
  virtual_networks = var.virtual_networks
}

# ================ Subnets =================
module "subnets" {
  depends_on = [module.virtual_network]
  source     = "../../module/subnets"
  subnets    = var.subnets
}

# ================ Network Interfaces =================
module "network_interfaces" {
  depends_on         = [module.subnets]
  source             = "../../module/network_interface"
  network_interfaces = var.network_interfaces
  subnet_ids         = module.subnets.subnet_ids 
}

# ================ Bastion Host =================
module "bastion_host" {
  depends_on    = [module.subnets]
  source        = "../../module/bastion_host"
  bastion_hosts = var.bastion_hosts
  subnet_ids    = module.subnets.subnet_ids # <-- FIX: 'subnets_ids' se 's' hata kar 'subnet_ids' kar diya
}

# ================ Virtual Machines =================
module "virtual_machines" {
  depends_on       = [module.network_interfaces]
  source           = "../../module/virtual_machine"
  virtual_machines = {
    for k, vm in var.virtual_machines : k => merge(vm, {
      network_interface_ids = [
        for nic_key in vm.network_interface_ids : module.network_interfaces.network_interfaces[nic_key].id
      ]
    })
  }
}