
# ============= Resource_Group =====================
module "resource_group" {
  source      = "../module/azurerm_resource_group"
  rg-practice = var.rg-practice
}

# ============= Virtual Network =====================
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../module/azurerm_virtual_network"
  vnets-prac = var.vnets-prac

}

# ============= Subnets =====================
module "Subnets" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_subnet"
  snets      = var.snets

}

# ============= Public_IP =====================
module "Public_IP" {
  depends_on = [module.virtual_network]
  source     = "../module/azurerm_public_ip"
  public_ips = var.public_ips

}

# ============= Virtual_Machine =====================
module "virtual_machine" {
  depends_on       = [module.Subnets, module.Public_IP]
  source           = "../module/azurerm_virtual_machine"
  virtual_macchine = var.virtual_macchine

}
