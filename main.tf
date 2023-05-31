#resource group
resource "azurerm_resource_group" "main" {
  name     = var.vm_name
  location = var.location
}

#generate password
resource "random_string" "vm_rndstr" {
  special = true
  upper   = true
  lower   = true
  numeric = true
  length  = 16
}

#timestamp offset
resource "time_offset" "secret_end" {
  offset_years = 2
}

#create keyvault secret
resource "azurerm_key_vault_secret" "vm_pwd" {
  name            = "${var.vm_name}-${var.vm_username}"
  value           = random_string.vm_rndstr.result
  key_vault_id    = var.keyvault_id
  expiration_date = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", time_offset.secret_end.rfc3339, )

  lifecycle {
    ignore_changes = [value, id, tags, key_vault_id, version, versionless_id]
  }
}

#create vm nic
resource "azurerm_network_interface" "nic" {
  name                = var.vm_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "default"
    subnet_id                     = var.subnet_id #data.azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [tags, ip_configuration]
  }
}

#vm
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  zone                            = var.vm_az != "" ? var.vm_az : null
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  size                            = var.vm_size
  admin_username                  = var.vm_username
  admin_password                  = random_string.vm_rndstr.result
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  lifecycle {
    ignore_changes = [identity, admin_password, os_disk, tags, boot_diagnostics]
  }

}

#add shell script to storage account
resource "azurerm_storage_account" "linux-agent" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "linux-agent" {
  name                  = "linux-agent"
  storage_account_name  = azurerm_storage_account.linux-agent.name
  container_access_type = "private"
}

resource "local_file" "linux-agent" {
  content  = data.template_file.script_template.rendered
  filename = "${path.module}/ext.sh"
}

resource "azurerm_storage_blob" "linux-agent" {
  name                   = "extension.sh"
  storage_account_name   = azurerm_storage_account.linux-agent.name
  storage_container_name = azurerm_storage_container.linux-agent.name
  type                   = "Block"
  source                 = local_file.linux-agent.filename
}

data "azurerm_storage_account_sas" "linux-agent" {
  connection_string = azurerm_storage_account.linux-agent.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2021-11-05T00:00:00Z"
  expiry = "2024-11-05T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = true
    process = true
    tag     = false
    filter  = false
  }
}

resource "azurerm_virtual_machine_extension" "azdo_extension" {
  name                 = "azdo-ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  protected_settings = <<PROTECTED_SETTINGS
    {
            "commandToExecute": "sh extension.sh",
            "storageAccountName": "${azurerm_storage_account.linux-agent.name}",
            "storageAccountKey": "${azurerm_storage_account.linux-agent.primary_access_key}",
            "fileUris": [
                "https://${azurerm_storage_account.linux-agent.name}.blob.core.windows.net/${azurerm_storage_container.linux-agent.name}/extension.sh"
            ]
    }
  PROTECTED_SETTINGS
}
