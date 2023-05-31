resource "azurerm_resource_group" "main" {
  name     = var.vm_vnet
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = var.vm_vnet
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_cidrs
}

resource "azurerm_subnet" "main" {
  name                 = var.vm_subnet
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  address_prefixes     = var.subnet_cidrs
}

resource "azurerm_key_vault" "main" {
  name                = var.keyvault_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_name            = var.keyvault_sku
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
}

module "azdo_agent" {
  source                      = "../."
  subnet_id                   = azurerm_subnet.main.id
  vm_vnet                     = azurerm_virtual_network.main.name
  vm_subnet                   = azurerm_subnet.main.name
  vnet_rsg                    = azurerm_virtual_network.main.resource_group_name
  keyvault_id                 = azurerm_key_vault.main.id
  keyvault_resourcegroup_name = azurerm_key_vault.main.resource_group_name
  script_pat_token            = var.script_pat_token
  script_azdo_org             = var.script_azdo_org
  script_agent_pool           = var.script_agent_pool
  depends_on = [
    azurerm_key_vault_access_policy.main
  ]
}
