
# Azure VM templates

This set of scripts allows to create a VM according the given specs in ```variables.tfvars```file. A simple way to use this snippets is to clone 

> The user must be authenticated in Azure (e.g. ```az login```) before running the commands.
<!--
See Azure B-Series VM sizes [here](https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/).
-->
----------------------------------------------
### Software requirements

Terraform
- Terraform v1.0.2
- Azurerm version ~>2.64.0

Aazure (optionnal)
- azure-cli 2.28.0 *


> Note : The script has been tested with the above versions but doesn't exclude other versions of these.

See Azure B-Series VM sizes [here](https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/).
Than you can go through the steps and begin to manage your application.

----------------------------------------------
To reproduce the lab:

```sh
C:\Users\Username> git clone https://github.com/can-er/azure-znuny-ubuntu
C:\Users\Username> cd azure-znuny-ubuntu
C:\Users\Username\azure-znuny-ubuntu> terraform init
C:\Users\Username\azure-znuny-ubuntu> terraform validate
C:\Users\Username\azure-znuny-ubuntu> terraform plan
C:\Users\Username\azure-znuny-ubuntu> terraform apply
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
  "friendlyname-1.location.cloudapp.azure.com/otrs/installer.pl",
  "friendlyname-0.location.cloudapp.azure.com/otrs/installer.pl",
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
