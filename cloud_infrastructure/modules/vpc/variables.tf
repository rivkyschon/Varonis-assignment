variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
}

variable "region" {
  description = "The region to deploy resources into"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnets" {
  description = "A list of subnets to create"
  type = list(object({
    subnet_name   = string
    subnet_ip     = string
    subnet_region = string
  }))
}
