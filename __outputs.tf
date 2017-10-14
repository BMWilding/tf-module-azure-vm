#########################################
# IP Outputs
#########################################
output public_ips  { value = ["${azurerm_public_ip.pi.*.ip_address}"] }
output public_dns  { value = ["${azurerm_public_ip.pi.*.fqdn}"] }
output private_mac_address { value = ["${azurerm_network_interface.ni.*.mac_address}"] }
output private_ips { value = ["${azurerm_network_interface.ni.*.private_ip_address}"] }
output private_dns { value = ["${azurerm_network_interface.ni.*.internal_fqdn}"] }


resource "consul_key_prefix" "virtual_machines" {
  count = "${length(var.vm_count)}"

  path_prefix = "azure/${var.app_id}/${var.environment}/${var.resource_group_name}/virtual_machines/${var.role}/${element(${azurerm_public_ip.pi.*.name}, "count.index")}/"

  subkeys = {
    "location"            = "${var.location}"
    "public_ips"          = "${element(${azurerm_public_ip.pi.*.name}, "count.index")}"
    "public_dns"          = "${element(${azurerm_public_ip.pi.*.name}, "count.index")}"
    "private_mac_address" = "${element(${azurerm_network_interface.ni.*.mac_address}, "count.index")}"
    "private_ip_address"  = "${element(${azurerm_network_interface.ni.*.private_ip_address}, "count.index")}"
    "private_fqdn"        = "${element(${azurerm_network_interface.ni.*.internal_fqdn}, "count.index")}"
  }
}
