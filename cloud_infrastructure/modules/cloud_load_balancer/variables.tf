variable "name" {
  description = "Name for the load balancer resources"
  type        = string
}

variable "region" {
  description = "Region for the load balancer resources"
  type        = string
}

variable "domain" {
  description = "Domain for the managed SSL certificate"
  type        = string
}

variable "project_id" {
  description = "Project ID where the load balancer resources will be created"
  type        = string
}
