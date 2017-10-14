#########################################
# Virtual NIC
#########################################
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
    subnet_id                     = "${data.consul_keys.keys.var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${var.create_public_ip ? element(concat(list("dummyforelementerror"),azurerm_public_ip.vm_pi.*.id), count.index+1) : ""}"
    load_balancer_backend_address_pools_ids = ["${compact(var.lb_pool_ids)}"]
  }

  tags = "${local.tags}"

}

resource "azurerm_public_ip" "vm_pi" {

  # Resource location
  location                = "${data.consul_keys.keys.var.location}"
  resource_group_name     = "${var.resource_group_name}"

  # Public IP Information
  count                        = "${var.create_public_ip ? var.vm_count : 0 }"
  name                         = "${lower(element(random_pet.vm_name.*.id, count.index))}-pip"
  domain_name_label            = "${lower(element(random_pet.vm_name.*.id, count.index))}"
  public_ip_address_allocation = "dynamic"
  tags = "${local.tags}"

}

#########################################
# Load Balancer
#########################################
resource "azurerm_lb" "test" {
  name                = "${var.app_id}-LoadBalancer"
  location            = "${data.consul_keys.keys.var.location}"
  resource_group_name     = "${var.resource_group_name}"
  tags = "${local.tags}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${var.lb_public ? element(concat(list("dummyforelementerror"),azurerm_public_ip.lb_pi.*.id), count.index+1) : ""}"
    private_ip_address_allocation = "${var.lb_public ? "" : "dynamic"}"
  }
}

resource "azurerm_public_ip" "lb_pi" {

  # Resource location
  location                = "${data.consul_keys.keys.var.location}"
  resource_group_name     = "${var.resource_group_name}"

  # Public IP Information
  count                        = "${var.lb_public ? 1 : 0 }"
  name                         = "${var.app_id}-loadbalancer-pip"
  domain_name_label            = "${var.app_id}-loadbalancer-pip"
  public_ip_address_allocation = "dynamic"
  tags = "${local.tags}"
}
