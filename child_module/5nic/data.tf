# data "azurerm_key_vault_secret" "keyvault_user" {
#   name         = "vmusername"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "keyvault_password" {
#   name         = "vmpassword"
#   key_vault_id = data.azurerm_key_vault.vault.id
# }