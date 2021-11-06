
# Azure VM templates

This set of scripts allows to create a set of VMs.

----------------------------------------------
### Software requirements

Terraform
- Terraform v1.0.2
- Azurerm version ~>2.64.0

Aazure (optionnal)
- azure-cli 2.28.0 


> Note : The script has been tested with the above versions but doesn't exclude other versions of these.

See Azure B-Series VM sizes [here](https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/).

The VMs will be created according the given specs in ```variables.tfvars``` file. These specs include the following variables:
```
# Username & Password settings
vm_username                 = "username"
keyvault_name               = "kvUserPass"
secret_name                 = "userpassword"
secret_value                = "changeme"
# Network & RG settings
resource_group_name         = "my_terraform_rg_demo"
resource_group_location     = "West Europe"
virtual_network_name        = "vnetdemo"
subnet_name                 = "subnetdemo"
public_ip_name              = "publicipdemo"
network_security_group_name = "nsgproddemo"
network_interface_name      = "nicproddemo"
friendlyappname             = "canervm"
# VM settings
linux_virtual_machine_name  = "linuxvmdemo"
vm_publisher                = "Canonical"
vm_offer                    = "UbuntuServer"
vm_SKU                      = "18.04-LTS"
vm_version                  = "latest"
vm_size                     = "Standard_B2ms"
numbercount                 = 1

```
To create your own VM refer to the available images via Azure CLI as follow:
```
C:\Users\Username> az vm image list --offer Windows-11 --all --output table
Offer       Publisher                Sku                   Urn                                                                           Version
----------  -----------------------  --------------------  ----------------------------------------------------------------------------  --------------------
windows-11  MicrosoftWindowsDesktop  win11-21h2-avd        MicrosoftWindowsDesktop:windows-11:win11-21h2-avd:22000.194.2109272003        22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-avd        MicrosoftWindowsDesktop:windows-11:win11-21h2-avd:22000.258.2110071642        22000.258.2110071642
windows-11  MicrosoftWindowsDesktop  win11-21h2-ent        MicrosoftWindowsDesktop:windows-11:win11-21h2-ent:22000.194.2109272003        22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-ent        MicrosoftWindowsDesktop:windows-11:win11-21h2-ent:22000.258.2110071642        22000.258.2110071642
windows-11  MicrosoftWindowsDesktop  win11-21h2-entn       MicrosoftWindowsDesktop:windows-11:win11-21h2-entn:22000.194.2109272003       22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-entn       MicrosoftWindowsDesktop:windows-11:win11-21h2-entn:22000.258.2110071642       22000.258.2110071642
windows-11  MicrosoftWindowsDesktop  win11-21h2-pro        MicrosoftWindowsDesktop:windows-11:win11-21h2-pro:22000.194.2109272003        22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-pro        MicrosoftWindowsDesktop:windows-11:win11-21h2-pro:22000.258.2110071642        22000.258.2110071642
windows-11  MicrosoftWindowsDesktop  win11-21h2-pro-zh-cn  MicrosoftWindowsDesktop:windows-11:win11-21h2-pro-zh-cn:22000.194.2109272003  22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-pro-zh-cn  MicrosoftWindowsDesktop:windows-11:win11-21h2-pro-zh-cn:22000.258.2110071642  22000.258.2110071642
windows-11  MicrosoftWindowsDesktop  win11-21h2-pron       MicrosoftWindowsDesktop:windows-11:win11-21h2-pron:22000.194.2109272003       22000.194.2109272003
windows-11  MicrosoftWindowsDesktop  win11-21h2-pron       MicrosoftWindowsDesktop:windows-11:win11-21h2-pron:22000.258.2110071642       22000.258.2110071642
```
> The user must be authenticated in Azure (e.g. ```az login```) before running the commands.
<!--
See Azure B-Series VM sizes [here](https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/).
-->
----------------------------------------------
To reproduce the lab:

```sh
C:\Users\Username> git clone https://github.com/can-er/azure-vm-template
C:\Users\Username> cd azure-vm-template\any-folder
C:\Users\Username\azure-vm-template\any-folder> terraform init
C:\Users\Username\azure-vm-template\any-folder> terraform validate
C:\Users\Username\azure-vm-template\any-folder> terraform plan
C:\Users\Username\azure-vm-template\any-folder> terraform apply
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

kv_id = ...
tls_private_key = <sensitive>
vault_uri = ...
vm_id = ...
vm_ip = [
  "XX.XX.XX.XX",
  "YY.YY.YY.YY",
  ...
]
urls_for_installation = [
  "friendlyname-1.location.cloudapp.azure.com",
  "friendlyname-0.location.cloudapp.azure.com",
  ...
]
```
----------------------------------------------
After doing these operations, you can login to your VM via SSH, RDP or WinRM according the arguments of the considering resource. See [VM's args](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#argument-reference) to list all existing connection types. 

<!--
### Possible issues :
* [Daemon not running](https://community.znuny.org/viewtopic.php?t=33255)
* [ICMP configuration](https://doc.otrs.com/doc/manual/admin/8.0/en/content/communication-notifications/postmaster-mail-accounts.html#manage-mail-accounts)
* [SMTP configuration](https://doc.otrs.com/doc/manual/admin/6.0/en/html/email-settings.html)
* [Queues management](https://doc.otrs.com/doc/manual/admin/8.0/en/content/ticket-settings/queues.html)
-->
<!--![alt text](http://51.38.34.56/az_vm.PNG) -->
