output "load_balancer_ids" {
    description = "Map of Load Balancer keys to their created Resource IDs"
    value = { for k, v in azurerm_lb.lb : k => v.id }  
}

