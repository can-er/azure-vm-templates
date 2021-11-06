output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

output "kv_id" {
  value = azurerm_key_vault.keyvault.id
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}

output "vm_ip" {
  description = "IPs of all FEs provisoned."
  value       = azurerm_windows_virtual_machine.windowsVm.*.public_ip_address
}

output "friendly_url" {
  description = "Friendly name to access the demo from the browser"
  #value = [for domain_name in azurerm_public_ip.public_ip.*.domain_name_label : format("${domain_name}.%s","${azurerm_resource_group.rg.location}.cloudapp.azure.com")]
  value = [for domain_name in azurerm_public_ip.public_ip.*.domain_name_label : "${domain_name}.${azurerm_resource_group.rg.location}.cloudapp.azure.com"]
}