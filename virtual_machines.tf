#########################################
# Generate Random Pet Name(s)
#########################################
resource "random_pet" "vm_name" {
  count = "${var.vm_count}"
}

#########################################
# Azure VM
#########################################

resource "azurerm_virtual_machine" "vm" {
  count                 = "${var.vm_count}"
  availability_set_id   = "${azurerm_availability_set.as.id}"
  name                  = "${lower(element(random_pet.vm_name.*.id, count.index))}"
  location                = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.ni.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"

  storage_os_disk {
    name              = "${lower(element(random_pet.vm_name.*.id, count.index))}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "${lower(element(random_pet.vm_name.*.id, count.index))}-datadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "64"
  }

  # TODO: DELETE THIS WHEN MOVED TO PACKER AZURE IMAGE
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
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

  tags = "${var.tags}"
}

#########################################
# Azure VM Availability Set
#########################################
resource "azurerm_availability_set" "as" {
  count               = "${var.vm_count != 0 ? 1 : 0}"
  name                = "${var.app_id}-as"
  location            = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  platform_fault_domain_count = "2"
  tags = "${var.tags}"
  managed = true
}
