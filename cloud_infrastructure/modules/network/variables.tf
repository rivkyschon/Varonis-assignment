variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "region" {
  type        = string
  description = "Region for the VPC and subnets"
}

variable "cloud_run_subnet_cidr" {
  type        = string
  description = "CIDR block for the Cloud Run subnet"
}

variable "lb_subnet_cidr" {
  type        = string
  description = "CIDR block for the load balancer subnet"
}

# Optional: For VPC Connector
variable "connector_cidr_range" {
  type        = string
  description = "CIDR block for the VPC connector"
  default     = null  
}