output "lb_rule_ids" {
    
    description = "Map of Load Balancer Rule keys to their created Resource IDs"
    value = { for k, v in azurerm_lb_rule.rule : k => v.id }
  
}