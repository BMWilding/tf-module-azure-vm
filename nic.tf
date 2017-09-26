# All VMs require a network interface
resource "azurerm_network_interface" "ni" {
  count                   = "${var.vm_count}"

  # Resource location
  location                = "${data.consul_keys.keys.var.location}"
  resource_group_name     = "${var.resource_group_name}"

  # NIC Name Information
  name                    = "${lower(element(random_pet.vm_name.*.id, count.index))}-nic"
  internal_dns_name_label = "${lower(element(random_pet.vm_name.*.id, count.index))}"

  # network_security_group_id = "${var.network_security_group_id}"

  ip_configuration {
    name                          = "${lower(element(random_pet.vm_name.*.id, count.index))}"
    subnet_id                     = "${data.consul_keys.keys.var.subnet}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.pi.*.id, count.index)}"
    load_balancer_backend_address_pools_ids = ["${compact(var.lb_pool_ids)}"]
  }

  tags = "${merge(var.custom_tags, module.tags.standard_tags)}"

}

resource "azurerm_public_ip" "pi" {

  # Resource location
  location                = "${data.consul_keys.keys.var.location}"
  resource_group_name     = "${var.resource_group_name}"

  # Public IP Information
  count                        = "${var.create_public_ip ? var.vm_count : 0 }"
  name                         = "${lower(element(random_pet.vm_name.*.id, count.index))}-pip"
  domain_name_label            = "${lower(element(random_pet.vm_name.*.id, count.index))}"
  public_ip_address_allocation = "dynamic"
  tags = "${merge(var.custom_tags, module.tags.standard_tags)}"

}
