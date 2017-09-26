#########################################
# Azure VM
#########################################

resource "azurerm_virtual_machine" "vm" {
  count                 = "${var.vm_count}"
  availability_set_id   = "${azurerm_availability_set.as.id}"
  name                  = "${lower(element(random_pet.vm_name.*.id, count.index))}"
  location              = "${data.consul_keys.keys.var.location}" 
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.ni.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"

  storage_os_disk {
    name          = "${lower(element(random_pet.vm_name.*.id, count.index))}-osdisk"
    vhd_uri       = "${data.consul_keys.keys.var.storage_path}${data.consul_keys.keys.var.disk_container}/${lower(element(random_pet.vm_name.*.id, count.index))}-osdisk.vhd"
    # image_uri     = "${module.image_templates.image_uri}"
    os_type       = "linux"
    create_option = "FromImage" # UNCOMMENT THIS WHEN CONVERTING TO AZURE IMAGE
  }

  # DELETE THIS WHEN MOVED TO PACKER AZURE IMAGE
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_data_disk {
    name          = "${lower(element(random_pet.vm_name.*.id, count.index))}-datadisk"
    vhd_uri       = "${data.consul_keys.keys.var.storage_path}${data.consul_keys.keys.var.disk_container}/${lower(element(random_pet.vm_name.*.id, count.index))}-datadisk.vhd"
    disk_size_gb  = "40"
    create_option = "Empty"
    lun           = 0
  }

  os_profile {
    computer_name  = "${lower(element(random_pet.vm_name.*.id, count.index))}"
    admin_username = "mytestuser12345"
    admin_password = "Mytestpassword12345"
    custom_data    = "${var.custom_data}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = "${merge(var.custom_tags, module.tags.standard_tags)}"
}

#########################################
# Azure VM Availability Set
#########################################
resource "azurerm_availability_set" "as" {
  count               = "${var.vm_count != 0 ? 1 : 0}"
  name                = "${lower(element(random_pet.vm_name.*.id, count.index))}-as"
  location            = "${data.consul_keys.keys.var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags = "${merge(var.custom_tags, module.tags.standard_tags)}"
}
