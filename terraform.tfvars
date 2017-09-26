vm_prefix             = "HECTIC"
app_name              = "My Hectic Application"
vm_count              = 3
environment           = "prod"
tags                  = {}

# Image Setup
vm_size               = "Standard_A1"
image_option          = "ubuntu-base"
custom_data           = ""

# Network Configuration
subnet_name           = "app"
create_public_ip      = true
lb_pool_ids           = []
nsg_id                = ""
