## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.vm_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.linux-agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_blob.linux-agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.linux-agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_virtual_machine_extension.azdo_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [local_file.linux-agent](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_string.vm_rndstr](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_offset.secret_end](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_secret.keyvault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_storage_account_sas.linux-agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_sas) | data source |
| [template_file.script_template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | keyvault rsg to store vm password and ADE key | `string` | `"demo12213412434"` | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | keyvault name to store vm password and ADE key | `string` | `"demo12213412434"` | no |
| <a name="input_keyvault_resourcegroup_name"></a> [keyvault\_resourcegroup\_name](#input\_keyvault\_resourcegroup\_name) | n/a | `any` | n/a | yes |
| <a name="input_kv_secret_name"></a> [kv\_secret\_name](#input\_kv\_secret\_name) | if enable\_get\_pwd\_from\_kv is set to true this value must be specified | `string` | `"demo"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Azure Bastion will be created | `string` | `"west europe"` | no |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | size of vm os disk in GB | `number` | `127` | no |
| <a name="input_script_agent_pool"></a> [script\_agent\_pool](#input\_script\_agent\_pool) | n/a | `string` | `"linux-self-hosted-pool2"` | no |
| <a name="input_script_azdo_org"></a> [script\_azdo\_org](#input\_script\_azdo\_org) | n/a | `string` | `""` | no |
| <a name="input_script_pat_token"></a> [script\_pat\_token](#input\_script\_pat\_token) | n/a | `string` | `""` | no |
| <a name="input_script_version"></a> [script\_version](#input\_script\_version) | azdo ext script | `string` | `"2.194.0"` | no |
| <a name="input_script_vm_user"></a> [script\_vm\_user](#input\_script\_vm\_user) | n/a | `string` | `"vm-admin"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `"demo12213412434"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | list of tags for resources | `list` | `[]` | no |
| <a name="input_vm_az"></a> [vm\_az](#input\_vm\_az) | vm availability zone | `any` | `null` | no |
| <a name="input_vm_image_offer"></a> [vm\_image\_offer](#input\_vm\_image\_offer) | n/a | `string` | `"UbuntuServer"` | no |
| <a name="input_vm_image_publisher"></a> [vm\_image\_publisher](#input\_vm\_image\_publisher) | n/a | `string` | `"Canonical"` | no |
| <a name="input_vm_image_sku"></a> [vm\_image\_sku](#input\_vm\_image\_sku) | n/a | `string` | `"18.04-LTS"` | no |
| <a name="input_vm_image_version"></a> [vm\_image\_version](#input\_vm\_image\_version) | n/a | `string` | `"latest"` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | n/a | `string` | `"demovm"` | no |
| <a name="input_vm_resource_group_name"></a> [vm\_resource\_group\_name](#input\_vm\_resource\_group\_name) | n/a | `string` | `"demovm"` | no |
| <a name="input_vm_rsg"></a> [vm\_rsg](#input\_vm\_rsg) | n/a | `string` | `"demo"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | vm size | `string` | `"Standard_B2s"` | no |
| <a name="input_vm_subnet"></a> [vm\_subnet](#input\_vm\_subnet) | vm subnet | `string` | `"demo"` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | `"vm-admin"` | no |
| <a name="input_vm_vnet"></a> [vm\_vnet](#input\_vm\_vnet) | vm vnet | `string` | `"demo"` | no |
| <a name="input_vnet_rsg"></a> [vnet\_rsg](#input\_vnet\_rsg) | n/a | `string` | `"demo"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all"></a> [all](#output\_all) | n/a |
| <a name="output_sas"></a> [sas](#output\_sas) | n/a |
| <a name="output_template"></a> [template](#output\_template) | n/a |
