# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">= 3.0"
#     }
#   }
# }

# Look up subnets for the NICs
data "azurerm_subnet" "snet" {
  for_each = var.nic_map

  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nic_map
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "${each.value.name}-ip"
    subnet_id                     = data.azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = lookup(each.value, "private_ip_allocation", "Dynamic")
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    public_ip_address_id          = lookup(each.value, "public_ip_id", null)
  }
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.nic_map
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Dynamic"
  
}


resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.nic_map
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd123"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic[each.key].id,]
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
}