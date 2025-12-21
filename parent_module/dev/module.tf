module "rg_module_01" {
  source  = "../../child_module/1resource_group"
  rg_map1 = var.rg1_var1
}

module "stg_module_02" {
  source     = "../../child_module/2storage_account"
  stg_map    = var.stg2_var2
  depends_on = [var.rg1_var1]
}

module "vnet_module_03" {
  source     = "../../child_module/3virtual_network"
  vnet_map   = var.vnet3_var3
  depends_on = [module.rg_module_01]
}

module "snet_module_04" {
  source     = "../../child_module/4subnet"
  snet_map   = var.snet4_var4
  depends_on = [module.vnet_module_03]
}

module "nic_vm_module_05" {
  source     = "../../child_module/5nic"
  nic_map    = var.nic_map
  depends_on = [module.snet_module_04]
}





