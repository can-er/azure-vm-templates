output "kv_id" {
  value = azurerm_key_vault.keyvault.id
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}
/*
output "vm_id" {
  value = azurerm_linux_virtual_machine.linuxvm.id
}
*/

/*
output "vm_ip" {
  value = azurerm_linux_virtual_machine.linuxvm.public_ip_address
}
*/

/*
output "vm_ip" {

  value = "${azurerm_public_ip.public_ip.*.ip_address}"
  
}*/


output "vm_ip" {
  description = "IPs of all FEs provisoned."
  value       = azurerm_linux_virtual_machine.linuxvm.*.public_ip_address
}

output "friendly_url" {
  description = "Friendly name to access the demo from the browser"
  #value = [for domain_name in azurerm_public_ip.public_ip.*.domain_name_label : format("${domain_name}.%s","${azurerm_resource_group.rg.location}.cloudapp.azure.com")]
  value = [for domain_name in azurerm_public_ip.public_ip.*.domain_name_label : "${domain_name}.${azurerm_resource_group.rg.location}.cloudapp.azure.com"]
}


output "tls_private_key" {
  value = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}
