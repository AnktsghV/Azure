module "resource_group" {
  source = "../Child Module/azure_resource_group"
  resource_groups = {
    rg1 = {
      name     = "rg-practice-module-3"  
      location = "East US"
    }
  }
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source = "../Child Module/azure_virtual_network"
  virtual_networks = {
    vnet1 = {
      name                = "vnet-practice-module-3"  
      address_space       = ["10.4.0.0/16"]  
      location            = "East US"
      resource_group_name = "rg-practice-module-3" 
    }
  }
}

module "subnet" {
  depends_on = [module.virtual_network]
  source = "../Child Module/azure_subnets"
  subnets = {
    subnet1 = {
      name                = "subnet-practice-module-3"  
      resource_group_name = "rg-practice-module-3" 
      virtual_network_name = "vnet-practice-module-3"  
      address_prefixes    = ["10.4.1.0/24"]  
    }
    subnet2 = {
      name                = "subnet-practice-module-4"  
      resource_group_name = "rg-practice-module-3"  
      virtual_network_name = "vnet-practice-module-3"  
      address_prefixes    = ["10.4.2.0/24"] 
    }
  }
}