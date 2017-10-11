#########################################
# Variables
#########################################

# VM Options
variable app_name              { type = "string" }
variable site                  { type = "string", default = "sydney"}
variable environment           { type = "string" }
variable cost_centre           { default = "None" }
variable app_id                { default = "None" }

variable consul_address        {}
variable consul_dc             {}

variable storage_type          { default = "Standard_GRS" }

variable custom_tags           { default = {}    }
variable custom_data           { type = "string", default = "" }

variable vm_count              { type = "string" }
variable vm_size               { default = "Standard_A1" } # https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/
# variable image_option          { type = "string" }

# Network Configuration
variable subnet_name           { default = "private" }
variable create_public_ip      { default = false  }
variable lb_pool_ids           { default = []     }
variable nsg_id                { default = ""     }


