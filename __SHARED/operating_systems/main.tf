variable os_option {
  default = "coreOS_latest"
}

# Stored in the format "image_publisher,image_offer,image_sku,image_version"
variable "OperatingSystems" {
  type = "map"

  default = {
    "CentOS_latest"         = "linux,openlogic,CentOS,7.2,latest"
    "Ubuntu16_10_latest"    = "linux,Canonical,UbuntuServer,16.10,latest"
    "windows2016_DC_latest" = "windows,MicrosoftWindowsServer,WindowsServer,2016-Datacenter,latest"
  }
}

output os_type {
  value = "${element("${split(",","${var.OperatingSystems["${var.os_option}"]}")}","0")}"
}

output image_publisher {
  value = "${element("${split(",","${var.OperatingSystems["${var.os_option}"]}")}","1")}"
}

output image_offer {
  #value = "${format("%s.%s.%s", "var", "${var.os_option}", "image_offer")}"
  value = "${element("${split(",","${var.OperatingSystems["${var.os_option}"]}")}","2")}"
}

output image_sku {
  #value = "${format("%s.%s.%s", "var", "${var.os_option}", "image_sku")}"
  value = "${element("${split(",","${var.OperatingSystems["${var.os_option}"]}")}","3")}"
}

output image_version {
  #value = "${format("%s.%s.%s", "var", "${var.os_option}", "image_version")}"  #
  value = "${element("${split(",","${var.OperatingSystems["${var.os_option}"]}")}","4")}"
}
