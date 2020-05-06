variable "resourcegroup_name" {
    type = string
}

variable "resourcegroup_location" {
    type = string
}

variable "teams" {
    type = string
    default = "tf"
  
}

variable "environment" {
    type = string
    default = "Terraform Getting Started"
  
}
