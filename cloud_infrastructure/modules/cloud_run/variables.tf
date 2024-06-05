variable "cr_name" {
  description = "Name for the load balancer resources"
  type        = string
}

variable "region" {
  description = "Region for the load balancer resources"
  type        = string
}

variable "project_id" {
  description = "Project ID where the load balancer resources will be created"
  type        = string
}

variable "image" {
  description = "image that runs on cloud run"
  type        = string
}