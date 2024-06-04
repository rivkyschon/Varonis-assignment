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

# Cloud Run Variables 
variable "cloud_run_service_name" {
  type        = string
  description = "Name of the Cloud Run service"
}

variable "cloud_run_image" {
  type        = string
  description = "URL of the container image to deploy"
}

variable "cloud_run_container_port" {
  type        = number
  description = "Port number the container listens on"
  default     = 8080
}

variable "cloud_run_memory" {
  type        = string
  description = "Memory limit for the Cloud Run service"
  default     = "512Mi"
}

# Load Balancer Variables 
variable "load_balancer_name" {
  type        = string
  description = "Name of the internal load balancer"
}

variable "load_balancer_type" {
  type        = string
  description = "Type of the load balancer (INTERNAL_MANAGED or INTERNAL_SELF_MANAGED)"
  default     = "INTERNAL_MANAGED"
}

# Cloud Armor Variables (Optional)
variable "cloud_armor_policy_name" {
  type        = string
  description = "Name of the Cloud Armor security policy"
  default     = null
}

variable "cloud_armor_rules" {
  type        = list(object({
    priority   = number
    action     = string
    expression = string
    description = string
  }))
  description = "List of Cloud Armor security policy rules"
  default     = []
}
