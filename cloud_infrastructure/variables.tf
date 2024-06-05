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

variable "location" {
  type        = string
  description = "The location where the repository will be created (e.g., 'us-central1')."
  default     = "us-central1"
}

variable "repository_id" {
  type        = string
  description = "The ID of the repository (e.g., 'my-docker-repo')."
}

variable "description" {
  type        = string
  description = "The description of the repository."
  default     = "Docker repository for my application"
}

variable "kms_key_name" {
  type        = string
  description = "The Cloud KMS key name for encrypting the repository data."
  default     = null  # Use Google-managed keys if not specified
}

variable "writer_members" {
  type        = list(string)
  description = "The list of members who will have write access to the repository."
  default     = []
}

variable "reader_members" {
  type        = list(string)
  description = "The list of members who will have read access to the repository."
  default     = []
}


# Add more variables here if you have additional ones in your terraform.tfvars file
# ... (other variables if applicable)
