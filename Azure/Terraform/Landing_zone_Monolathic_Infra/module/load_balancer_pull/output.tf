output "backend_pool_ids" {
    description = "values for backend pools to be created with their configuration details like name, resource group, and load balancer id"
    value = {for k, v in azurerm_lb_backend_address_pool.lb_backend_pool : k => v.id }
  
}