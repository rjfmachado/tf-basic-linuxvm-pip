output "privateip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "publicip" {
  value = azurerm_public_ip.pip.ip_address
}

output "fqdn" {
  value = azurerm_public_ip.pip.fqdn
}
