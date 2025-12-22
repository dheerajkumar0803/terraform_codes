data "azurerm_subnet" "patna_snet2" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "dheeraj_vnet"
  resource_group_name  = "dheeraj1"
}

data "azurerm_public_ip" "pip" {
  name                = "bastion-pip"
  resource_group_name = "dheeraj1"
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion_map
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                 = ip_configuration.value.name
      subnet_id            = data.azurerm_subnet.patna_snet2.id
      public_ip_address_id = data.azurerm_public_ip.pip.id
    }
  }

}
