resource "azurerm_lb_probe" "lb_probe" {
    for_each = var.health_probes

    name                = each.value.name
    loadbalancer_id     = each.value.loadbalancer_id
    protocol            = lookup(each.value, "protocol", null)
    port                = each.value.port
    request_path = lookup(each.value, "request_path", null)
  
}