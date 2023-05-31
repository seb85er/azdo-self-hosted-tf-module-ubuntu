variable "location" {
  default = "West Europe"
}

variable "vm_vnet" {
  description = "vm vnet"
  default     = "demo"
}

variable "vnet_cidrs" {
  description = "address space for virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_cidrs" {
  description = "subnet address space"
  default     = ["10.0.0.0/24"]
}

variable "vm_subnet" {
  description = "vm subnet"
  default     = "demo"
}

variable "keyvault_name" {
  default = "kv-azdo-demo-9871"
}


variable "keyvault_sku" {
  description = "sku for the keyvault standard or premium"
  default     = "standard"
}

variable "script_pat_token" {
  default = "xxx"
}

variable "script_azdo_org" {
  default = "xxx"
}

variable "script_agent_pool" {
  default = "linux-self-hosted-pool"
}