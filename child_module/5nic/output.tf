# output "nic_ids" {
#   description = "Map of NIC ids created by this module"
#   value = { for k, v in azurerm_network_interface.nic : k => v.id }
# }

# output "nic_private_ips" {
#   description = "Private IP addresses assigned to NICs"
#   value = { for k, v in azurerm_network_interface.nic : k => v.ip_configuration[0].private_ip_address }
# }
