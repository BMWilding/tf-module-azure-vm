#########################################
# Variables
#########################################

variable app_name              { }
variable app_id                { }
variable subnet_name           { }
variable cost_centre           { }

output standard_tags {
  value = {
        "App Name"    = "${var.app_name}"
        "App ID"      = "${var.app_id}"
        "Subnet Name" = "${var.subnet_name}"
        "Cost Centre" = "${var.cost_centre}"
    }
}
