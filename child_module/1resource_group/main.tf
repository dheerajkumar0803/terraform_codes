resource "azurerm_resource_group" "patna_rg" {
  for_each = var.rg_map1
  
  name     = each.value.name
  location = each.value.location
}
