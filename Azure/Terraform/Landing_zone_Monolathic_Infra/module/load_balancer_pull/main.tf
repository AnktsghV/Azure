resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
    for_each = var.backend_pools
    name                = each.value.name
    loadbalancer_id     = each.value.loadbalancer_id
}