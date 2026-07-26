resource "azurerm_resource_group" "rg_win_prac" {
    for_each = var.rg_win
    name = each.value.name
    location = each.value.location
  
}