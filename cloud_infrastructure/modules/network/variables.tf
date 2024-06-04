variable "vpc_name" {
  type        = string
  description = "Name of the VPC to create."
}

variable "region" {
  type        = string
  description = "The region to deploy resources into."
}

variable "cloud_run_subnet_cidr" {
  type        = string
  description = "CIDR block for the Cloud Run subnet."
}

variable "lb_subnet_cidr" {
  type        = string
  description = "CIDR block for the load balancer subnet."
}
