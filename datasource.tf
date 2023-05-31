data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secret" "keyvault_secret" {
  name         = azurerm_key_vault_secret.vm_pwd.name
  key_vault_id = var.keyvault_id
}

data "template_file" "script_template" {
  template = file("${path.module}/templates/extension.tpl")
  vars = {
    script_version    = var.script_version,
    script_pat_token  = var.script_pat_token,
    script_azdo_org   = var.script_azdo_org,
    script_agent_pool = var.script_agent_pool
    script_vm_user    = var.script_vm_user
  }
}
