terraform {
  required_version = ">= 1.5.0"
}

module "resource_groups" {  
    source = "../../module/resource_group"
        resource_groups = var.resource_groups
}

module "virtual_network" {
    depends_on = [ module.resource_groups ]
    source = "../../module/virtual_network"
        vnets = var.vnets
}

module "subnets" {
    depends_on = [ module.virtual_network ]
    source = "../../module/subnets"
    subnets = var.subnets
}

module "nsg" {
    depends_on = [ module.subnets ]
    source = "../../module/network_security_group"
        nsgs = var.nsgs
}

module "nic" {
    depends_on = [ module.nsg ]
    source = "../../module/network_interface_card"
        nics = {
            for k, v in var.nics : k => {
      name                = v.name
      location            = v.location
      resource_group_name = v.resource_group_name
      virtual_network_name = var.vnets["vnet1"].name
      subnet_name         = var.subnets[v.subnet_key].name
      private_ip_address  = lookup(v, "private_ip_address", null)
      subnet_id           = module.subnets.subnet_ids[v.subnet_key]
    }
    }
}

module "virtual_machine" {
    depends_on = [ module.nic ]
    source = "../../module/virtual_machine"
    vms = {
        for k, v in var.vms : k => {
            name                            = v.name
            location                        = v.location
            resource_group_name             = v.resource_group_name
            network_interface_ids           = [module.nic.nic_ids[v.nic_key]]
            vm_size                         = v.size
            admin_username                  = v.admin_username
            admin_password                  = v.admin_password
            disabled_password_authentication = false
            os_disk_caching                 = v.os_disk.caching
            os_disk_storage_account_type    = v.os_disk.storage_account_type
            source_image_reference_publisher = v.source_image_reference.publisher
            source_image_reference_offer     = v.source_image_reference.offer
            source_image_reference_sku       = v.source_image_reference.sku
            source_image_reference_version   = v.source_image_reference.version
            tags                            = lookup(v, "tags", {})
        }
    }
}

module "load_balancer" {
    depends_on = [ module.resource_groups ]
    source = "../../module/load_balancer"
        load_balancers = var.load_balancers
  
}

module "backend_pool" {
    depends_on = [ module.load_balancer ]
    source = "../../module/load_balancer_pull"
        backend_pools = {
            for k, v in var.backend_pools : k => merge(v, {
      loadbalancer_id = module.load_balancer.load_balancer_ids[v.lb_key]
    })
    }  
}

module "health_probe" {
    depends_on = [ module.load_balancer ]
    source = "../../module/health_probe"
        health_probes = {
            for k, v in var.health_probes : k => merge(v, {
      loadbalancer_id = module.load_balancer.load_balancer_ids[v.lb_key]
    })
    }
  
}

module "lb_rule" {
    depends_on = [ module.backend_pool,module.health_probe ]
    source = "../../module/lb_rule"
        lb_rules = {
            for k, v in var.lb_rules : k => merge(v, {
      loadbalancer_id = module.load_balancer.load_balancer_ids[v.lb_key]
      port = v.frontend_port
      backend_address_pool_ids = [module.backend_pool.backend_pool_ids[v.pool_key]]
      probe_id = module.health_probe.health_probe_ids[v.probe_key]
    })
    }   
  
}

module "bastion" {
    depends_on = [ module.subnets ]
    source = "../../module/bastion"
        bastions = {
            for k, v in var.bastions : k => merge(v, {
      subnet_id = module.subnets.subnet_ids[v.subnet_key]
    })
    }
  
}

module "key_vault" {
    depends_on = [ module.resource_groups ]
    source = "../../module/key_vault"
        key_vaults = {
    for k, v in var.key_vaults : k => merge(v, {
      tenant_id = data.azurerm_client_config.current.tenant_id
    })
        }
  
}

module "key_vault_secret" {
  source = "../../module/key_vault_secert"
  key_vault_secrets = {
    for k, v in var.key_vault_secrets : k => merge(v, {
      key_vault_id = module.key_vault.key_vault_ids[v.kv_key]
    })
  }
  depends_on = [module.key_vault]
}


module "storage" {
  source = "../../module/storage"
  storage_accounts = var.storage_accounts
  depends_on  = [module.resource_groups]
}