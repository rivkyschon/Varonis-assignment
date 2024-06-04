variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
}

variable "region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
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