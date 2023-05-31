variable "location" {
  description = "The Azure Region where the Azure Bastion will be created"
  default     = "west europe"
}

variable "tags" {
  description = "list of tags for resources"
  default     = []
}

variable "vm_az" {
  description = "vm availability zone"
  default     = null
}

variable "vm_size" {
  description = "vm size"
  default     = "Standard_B2s"
}

variable "os_disk_size" {
  description = "size of vm os disk in GB"
  default     = 127
}

variable "vm_name" {
  default = "demovm"
}

variable "vm_username" {
  default = "vm-admin"
}

variable "vm_vnet" {
  description = "vm vnet"
  default     = "demo"
}
variable "vm_subnet" {
  description = "vm subnet"
  default     = "demo"
}

variable "subnet_id" {
}

variable "vnet_rsg" {
  default = "demo"
}
variable "vm_rsg" {
  default = "demo"
}

variable "keyvault_name" {
  description = "keyvault name to store vm password and ADE key"
  default     = "demo12213412434"
}

variable "keyvault_resourcegroup_name" {
}
variable "keyvault_id" {
  description = "keyvault rsg to store vm password and ADE key"
  default     = "demo12213412434"
}
variable "vm_resource_group_name" {
  default = "demovm"
}


variable "kv_secret_name" {
  description = "if enable_get_pwd_from_kv is set to true this value must be specified"
  default     = "demo"
}

variable "vm_image_publisher" {
  default = "Canonical"
}

variable "vm_image_offer" {
  default = "UbuntuServer"
}

variable "vm_image_sku" {
  default = "18.04-LTS"
}

variable "vm_image_version" {
  default = "latest"
}

variable "storage_account_name" {
  default = "demo12213412434"
}


#azdo ext script
variable "script_version" {
  default = "2.194.0"
}

variable "script_pat_token" {
  default = ""
}

variable "script_azdo_org" {
  default = ""
}

variable "script_agent_pool" {
  default = "linux-self-hosted-pool2"
}

variable "script_vm_user" {
  default = "vm-admin"
}


