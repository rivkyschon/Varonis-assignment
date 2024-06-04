variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
}

variable "region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1"  # Optional, you can provide a default value
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

variable "cloud_run_service_name" {
  type        = string
  description = "Name of the Cloud Run service"
}

variable "cloud_run_image" {
  type        = string
  description = "URL of the container image to deploy"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the internal load balancer"
}

# Add more variables here if you have additional ones in your terraform.tfvars file
# ... (other variables if applicable)
