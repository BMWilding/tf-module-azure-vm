#########################################
# Packer Images - Core Services
#########################################
/*
module "image_templates" {
  source = "./__SHARED/image_options"
  image_option = "${var.image_option}"
}
*/

data "consul_keys" "keys" {
  key { name = "subnet" path = "core/${var.site}/network/${var.subnet_name}_subnet" }
  key { name = "location" path = "core/${var.site}/location" }
  key { name = "storage_path" path = "core/${var.site}/storage/${var.storage_type}/primary_blob_endpoint" }
  key { name = "storage_name" path = "core/${var.site}/storage/${var.storage_type}/name" }
  key { name = "disk_container" path = "core/${var.site}/storage/${var.storage_type}/disk_container"}
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
