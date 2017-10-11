app_name             = "TEST_APP"
site                 = "sydney"
environment          = "odev"
cost_centre          = "123456"
app_id               = "A00001"

storage_type         = "Standard_GRS"

vm_count             = 2
vm_size              = "Standard_A1" 

# Network Configuration
subnet_name          = "private" 
create_public_ip     = false

consul_address  = "consul.australiaeast.cloudapp.azure.com:8500"
consul_dc       = "australiaeast"