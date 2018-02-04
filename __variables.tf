#########################################
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters
#########################################

variable "app_id" { 
    description = "The Westpac Application ID used to tie a deployment back to the Application Inventory"
    type = "string"
}

variable "resource_group_name" {
    description = "The Resource Group in which these vms will be provisioned"
    type = "string"
}

variable "role" {
    description = "What is the functional role of this server in the context of the application (e.g. Web Server)"
    type = "string"
}

variable location {
    description = "Which azure location will these virtual machines be deployed?"
    type = "string"
}

variable vm_count {
    description = "How many virtual machines are to be provisioned"
    type = "string" 
}

variable subnet_id {
    description = "The subnet in which this vm deployment will occur"
    type = "string"
}

# variable image_option        { type = "string"  }
variable lb_pool_ids           { default = []     }
variable nsg_id                { default = ""     }

#########################################
# LOAD BALANCER
# Does this VM need to be load balanced
#########################################

variable lb_enabled {
    description = "Do the provisioned machines need to be load balanced?"
    default = false
}

variable lb_public {
    description = "Is this a public facing load balancer?"
    default = false
}


variable lb_rules {
    description = "A list of comma deliniated strings of the Load Balancing Rules, including Health Check endpoints"
    default = [""]
}

#########################################
# OPTIONAL PARAMETERS
# These Parameters have reasonable defaults
#########################################
variable vm_size  {
    description = "What size should the virtual machines be? Sizes available at https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/"
    default = "Standard_A1" 
    type = "string"
}

variable custom_data {
    description = "Bootstrap script for the virtual machine"
    default = ""
    type = "string"
}

variable tags {
    description = "Any additional tags to be added to the workloads"
    default = {}
    type = "map"
}

variable storage_type {
    description = "The standard of storage used by VM Managed Disks. Options are Standard_LRS and Premium_LRS"
    default = "Standard_LRS"
    type = "string"
}

variable create_public_ip {
    description = "Should this Virtual Machine have a Publically routable IP Address?"
    default = false  
    type = "string"
}