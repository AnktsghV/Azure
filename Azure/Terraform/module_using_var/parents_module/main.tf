module "resource_group" {
  source         = "../child_module/azurerm_resource_group"
  resource_group = var.resource_groups
}

module "virtual_network" {
  depends_on      = [module.resource_group]
  source          = "../child_module/azurerm_virtual_network"
  virtual_network = var.virtual_network
}

module "subnets" {
  depends_on      = [module.virtual_network]
  source  = "../child_module/azurerm_subnets"
  subnets = var.subnets
}