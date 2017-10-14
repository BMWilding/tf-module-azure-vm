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
  key { name = "cost_centre" path = "azure/${var.app_id}/cost_centre" }
  key { name = "app_name" path = "azure/${var.app_id}/app_name" }
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
        "Cost Centre" , "${data.consul_keys.keys.var.cost_centre}",
        "App Name"    , "${data.consul_keys.keys.var.app_name}"
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

