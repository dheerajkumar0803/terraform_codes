# data "azurerm_subnet" "patna_snet" {
#   for_each = var.snet_map

#   name                 = each.value.name
#   virtual_network_name = each.value.virtual_network_name
#   resource_group_name  = each.value.resource_group_name
# }
