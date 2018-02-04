#########################################
# IP Outputs
#########################################
output public_ips  { value = ["${azurerm_public_ip.vm_pi.*.ip_address}"] }
output public_dns  { value = ["${azurerm_public_ip.vm_pi.*.fqdn}"] }
output private_mac_address { value = ["${azurerm_network_interface.ni.*.mac_address}"] }
output private_ips { value = ["${azurerm_network_interface.ni.*.private_ip_address}"] }
output private_dns { value = ["${azurerm_network_interface.ni.*.internal_fqdn}"] }
