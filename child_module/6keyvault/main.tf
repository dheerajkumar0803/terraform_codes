data "azurerm_client_config" "id_tenant" {}

data "azurerm_key_vault" "kv" {
  name                = "dheerajkeyvault"
  resource_group_name = "dheeraj1"
}

resource "azurerm_key_vault" "vault_map" {
  for_each = var.keyvault_var

  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.id_tenant.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.id_tenant.tenant_id
    object_id = data.azurerm_client_config.id_tenant.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


resource "azurerm_key_vault_secret" "keyvault_user" {
  for_each     = var.keyvault_var
  name         = "vmusername"
  value        = "dheerajuser"
  key_vault_id = azurerm_key_vault.vault_map[each.key].id
}

resource "azurerm_key_vault_secret" "keyvault_password" {
  for_each     = var.keyvault_var
  name         = "vmpassword"
  value        = "Dheeraj@12345"
  key_vault_id = azurerm_key_vault.vault_map[each.key].id
}
