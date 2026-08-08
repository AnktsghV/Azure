resource "azurerm_lb_rule" "rule" {
    for_each = var.lb_rules

    name                = each.value.name
    loadbalancer_id     = each.value.loadbalancer_id
    protocol            = "Tcp"
    frontend_port       = each.value.port
    backend_port        = each.value.port
    frontend_ip_configuration_name = "PublicIPAddress"
    backend_address_pool_ids        = each.value.backend_address_pool_ids
    probe_id                       = lookup(each.value, "probe_id", null)
  
}