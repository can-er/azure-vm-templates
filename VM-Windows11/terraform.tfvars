# Username & Password settings
vm_username                 = "caner"
keyvault_name               = "kvUserPassWin11"
secret_name                 = "userpassword"
secret_value                = "MonPassUltraChaud1140"
# Network & RG settings
resource_group_name         = "Windows11VM"
resource_group_location     = "West Europe"
virtual_network_name        = "vnetdemo"
subnet_name                 = "subnetdemo"
public_ip_name              = "publicipdemo"
network_security_group_name = "nsgproddemo"
network_interface_name      = "nicproddemo"
friendlyappname             = "canervm"
# VM settings
linux_virtual_machine_name  = "win11vmdemo"
vm_publisher                = "MicrosoftWindowsDesktop"
vm_offer                    = "Windows-11"
vm_SKU                      = "win11-21h2-pro"
vm_version                  = "22000.258.2110071642"
vm_size                     = "Standard_B2ms"
scriptname                  = "install_znuny.sh"
numbercount                 = 1
