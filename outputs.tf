output "template" {
  value = data.template_file.script_template.template
}

output "all" {
  value = data.template_file.script_template
}

output "sas" {
  value = data.azurerm_storage_account_sas.linux-agent.sas
}

