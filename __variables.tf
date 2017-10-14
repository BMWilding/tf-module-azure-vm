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

variable site {
    description = "What site will this VM(s) be deployed (e.g. Sydney or Melbourne)"
    type = "string"
}

variable environment {
    description = "Which logical environment will this virtual machine be deployed. Options are Prod, Non-Prod and ODev"
    type = "string"
}

variable cost_centre {
    description = "What is the cost centre to be used for recharging"
    type = "string"
}

variable vm_count {
    description = "How many virtual machines are to be provisioned"
    type = "string" 
}

# variable image_option          { type = "string" }

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

#########################################
# OPTIONAL PARAMETERS
# These Parameters have reasonable defaults
#########################################
variable vm_size  {
    description = "What size should the virtual machines be? Sizes available at https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/"
    default = "Standard_A1" 
    type = "string"
}


variable storage_type {
    description = "The standard of storage used by VM Managed Disks. Options are Standard_LRS and Premium_LRS"
    default = "Standard_LRS"
    type = "string"
}

variable custom_tags {
    description = "Any additional tags to be added to the workloads"
    default = {}
    type = "map"
}

variable subnet_name { 
    description = "What is the name of the subnet where Virtual Machines will be provisioned. This value, alongside Environment, will pull a Subnet_ID from Consul"
    default = "private" 
    type = "string"
}

variable create_public_ip {
    description = "Should this Virtual Machine have a Publically routable IP Address?"
    default = false  
    type = "string"
}


#########################################
# TEMPORARY PARAMETERS
# TBA
#########################################
variable consul_address        {}
variable consul_dc             {}
variable custom_data           { type = "string", default = "" }
