
# SCHEMA HAS CHANGED SIGNIFICANTLY. UPDATES COMING ASAP.

# Virtual Machine Module
This module is used to build a virtual machine

## Mandatory variables

Variable    | Description
--------    | -----------
app_name         | Name of the application being deployed
vm_prefix        | Prefix to identify the VM ( eg. AD = Active Directory, or MONGODB = MongoDB )
vm_count         | How many servers will be deployed
environment      | This variable is used to decide which "remote state" the resource will contextual data. Choice of __prod__, __dev__ or __test__.
subnet_name      | The name of the subnet where the VM will be deployed. Defined in remote state for the core using the output subnet_ids.
image_option     |  Operating system to be deployed
custom_tags      |  Any custom tags that will be applied to the machine


## Optional Variables

Variable | Description
-------- | -----------
create_public_ip              | Should a public IP be assigned to the vm (default = false).
vm_size                       | Size of the VM. [Link to Azure VM Sizes](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/) (default = Standard_A1)
nsg_id                        | ID of an NSG if the VM exists in a Network Security Group
lb_pool_ids                   | Load Balancer ID if the vm is sitting behind an Azure LB
count_offset                  | If the VM isn't starting at 1, what number shall it start.
cost_centre                   | Cost Centre for VM Chargeback
app_id                        | Application ID identifier

## Example call to the module

```
module "vm" {
  source = "..."

  vm_prefix             = "testapp"
  app_name              = "My Amazing Test Application"
  vm_count              = 3
  environment           = "prod"
  custom_tags           = {
                            tag1 = "tag1"
                            tag2 = "tag2"
                          }

  # Image Setup
  vm_size               = "Standard_A1"
  image_option          = "ubuntu-base"

  # Network Configuration
  subnet_name           = "app"
  create_public_ip      = true

}

```
