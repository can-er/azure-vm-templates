variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
}

variable "vm_username" {
  type        = string
  description = "Username used to SSH to the VM"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
}

variable "secret_name" {
  type        = string
  description = "Key Vault Secret name in Azure"
}

variable "secret_value" {
  type        = string
  description = "Password used to SSH the VM"
  sensitive   = true
}

variable "virtual_network_name" {
  type        = string
  description = "VNET name in Azure"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name in Azure"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name in Azure"
}

variable "network_security_group_name" {
  type        = string
  description = "NSG name in Azure"
}

variable "network_interface_name" {
  type        = string
  description = "NIC name in Azure"
}

variable "linux_virtual_machine_name" {
  type        = string
  description = "Linux VM name in Azure"
}

variable "vm_publisher" {
  type        = string
  description = "Publisher of the VM. Example: Canonical"
}

variable "vm_offer" {
  type        = string
  description = "Name of the distrib. Example: UbuntuServer"
}

variable "vm_SKU" {
  type        = string
  description = "SKU of the VM. Example: 18.04-LTS"
}

variable "vm_version" {
  type        = string
  description = "Version of the VM. Example: latest"
}

variable "vm_size" {
  type        = string
  description = "Size of the VM. Example: Standard_B2ms"
}

variable "numbercount" {
    type      = number
    description = "N of VMs to deploy"
} 

variable "friendlyappname" {
  type        = string
  description = "subdomain of the app"
}

variable "scriptname" {
  type        = string
  description = "Script to run for provisionning the VMs"
}
