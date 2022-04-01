data "azurerm_client_config" "current" {}
# Loading current client config

# Creating a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = "production"
  }

}

# Creating a key vault resource
resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
      "get",
      "purge",
      "delete",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "purge",
    ]

    storage_permissions = [
      "get",
      "purge",
      "delete",
    ]

  }

# Allows to add network access control lists that acts as a firewall for controlling traffic in and out
  # network_acls {
  #   default_action = "Deny" # "Allow" 
  #   bypass         = "AzureServices" # "None"
  #   ip_rules = ["50.50.50.50/24"]
  # }
}

# Creating the key vault secret and linking to the previously created key vault 
resource "azurerm_key_vault_secret" "user-pwd" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Another way to create key vault access policy instead of doing through azurerm_key_vault resource
# resource "azurerm_key_vault_access_policy" "policy" {
#   key_vault_id = azurerm_key_vault.keyvault.id
#
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = "11111111-1111-1111-1111-111111111111" # SPN ID
#
#   key_permissions = [
#     "get",
#   ]
#
#   secret_permissions = [
#     "get",
#   ]
# }

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "production"
  }
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  count               = var.numbercount
  name                = "vm-ip-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.friendlyappname}-${count.index}"
  

  tags = {
    environment = "production"
  }
}

# Create Network Security Group and rule

resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "production"
  }
}



# Create network interface
resource "azurerm_network_interface" "nic" {
  count               = var.numbercount
  name                = "vm-nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.public_ip.id
    public_ip_address_id          = element(azurerm_public_ip.public_ip.*.id, count.index)
  }

  tags = {
    environment = "production"
  }
}

# Connect the security group to the network interface
/*
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
*/

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "linuxvm" {
  count                 = var.numbercount
  name                  = "vm-stg-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  size                  = "Standard_B2ms"

  os_disk {
    name                 = "osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_SKU
    version   = var.vm_version
  }

  computer_name                   = "myvm-${count.index}"
  admin_username                  = var.vm_username
  disable_password_authentication = false
  admin_password = var.secret_value

  admin_ssh_key {
    username   = var.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage.primary_blob_endpoint
  }
  
  provisioner "file" {

    connection {
      host        = azurerm_public_ip.public_ip[count.index].ip_address
      type        = "ssh"
      user        = var.vm_username
      private_key = file("~/.ssh/id_rsa")
    }

    source      = var.scriptname
    destination = "/home/${var.vm_username}/${var.scriptname}"
  }


  provisioner "remote-exec" {
    
    connection {
      host =  "${azurerm_public_ip.public_ip[count.index].ip_address}"
      type = "ssh"
      user = var.vm_username
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    inline = [
      "sudo chmod +x /home/${var.vm_username}/${var.scriptname}",
      "sudo /home/${var.vm_username}/${var.scriptname} && sudo rm -f /home/${var.vm_username}/${var.scriptname}",
    ]
  }

  tags = {
    environment = "production"
  }
}
