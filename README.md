# Azure-VM-templates


* This script allows to create N virtual machines and is responsible in provisionning the machines in an Azure environment. The user must be authenticated in Azure before running the commands.
* The provisionning of the VMs has been made with the installer ```install_znuny.sh``` which is copied and run on all the hosts after applying ```terraform apply```. The installation is based on the [official documentation instructions](https://doc.znuny.org/manual/releases/installupdate/install.html#installation).

### Software requirements

Perl
- Perl 5.16.0 or higher
- Perl packages listed by /opt/otrs/bin/otrs.CheckEnvironment.pl console command

Web Server
- Apache2

Database
-  MariaDB 10.1.48

> Note : The script has been tested on Ubuntu 18.04 LTS (VM size: *Standard B1ms* which means *1 vCPU, 2 GiB memory*)

See Azure B-Series VM sizes [here](https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/).

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
After doing these operations, you can launch the installer by visiting: <http://friendlyname-0.location.cloudapp.azure.com/otrs/installer.pl> as shown below: 
![alt text](http://51.38.34.56/znuny_installer)

Than you can go through the steps and begin to manage your application.

----------------------------------------------

### Possible issues :
* [Daemon not running](https://community.znuny.org/viewtopic.php?t=33255)
* [ICMP configuration](https://doc.otrs.com/doc/manual/admin/8.0/en/content/communication-notifications/postmaster-mail-accounts.html#manage-mail-accounts)
* [SMTP configuration](https://doc.otrs.com/doc/manual/admin/6.0/en/html/email-settings.html)
* [Queues management](https://doc.otrs.com/doc/manual/admin/8.0/en/content/ticket-settings/queues.html)

<!--![alt text](http://51.38.34.56/az_vm.PNG) -->
