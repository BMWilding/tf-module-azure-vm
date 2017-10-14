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

##################################
## Standard Tags
##################################
locals {
  tags = "${
    merge(
      var.custom_tags, 
      map(
        "App ID"      , "${var.app_id}",
        "Subnet Name" , "${var.subnet_name}",
        "Cost Centre" , "${var.cost_centre}"
      )
    )
  }"
}

#########################################
# Generate Random Pet Name(s)
#########################################
resource "random_pet" "vm_name" {
  count = "${var.vm_count}"
}

