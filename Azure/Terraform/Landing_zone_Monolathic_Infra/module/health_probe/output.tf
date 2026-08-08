output "health_probe_ids" { 
    description = "Map of Health Probe keys to their created Resource IDs"
    value = { for k, v in azurerm_lb_probe.lb_probe : k => v.id }
}