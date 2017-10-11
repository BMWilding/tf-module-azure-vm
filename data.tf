###################################
## Consul
###################################
provider "consul" {
  address    = "${var.consul_address}"
  datacenter = "${var.consul_dc}"
}

data "consul_keys" "keys" {
  key { name = "subnet_id" path = "azure/${var.environment}/core/${var.site}/network/${var.subnet_name}_subnet" }
  key { name = "location" path = "azure/${var.environment}/core/${var.site}/location" }
} 


###################################
## Resource Group
###################################
resource "azurerm_resource_group" "rg" {
  name     = "${var.app_id}-${var.environment}"
  location = "${data.consul_keys.keys.var.location}"
} 


#########################################
# Create Standard Tags
#########################################
module "tags" {
  source = "./__SHARED/vm_tags"

  app_name     = "${var.app_name}"
  app_id       = "${var.app_id}"
  subnet_name  = "${var.subnet_name}"
  cost_centre  = "${var.cost_centre}"
}

#########################################
# Generate Random Pet Name(s)
#########################################
resource "random_pet" "vm_name" {
  count = "${var.vm_count}"
}