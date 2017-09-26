variable image_option { default = "ubuntu-base" }
variable release      { default = "latest"      }
variable environment  { default = "prod"        }

data "consul_keys" "machine_name" {
  # Read the virtual machine from consul
  key {
    name    = "uri"
    path    = "azure/prod/machine_images/${var.image_name}/${var.release}/"
  }
}

output "machine_image_uri" {
  value = "${data.consul_keys.machine_name.var.uri}"
}
