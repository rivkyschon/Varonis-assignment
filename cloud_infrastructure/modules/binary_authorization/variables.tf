variable "project_id" {
  description = "The ID of the project in which to create the resources."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "attestor_id" {
  description = "The ID of the Binary Authorization attestor."
  type        = string
  default     = "cb-attestor"
}

variable "key_ring_name" {
  description = "The name of the KMS key ring."
  type        = string
}

variable "crypto_key_name" {
  description = "The name of the KMS crypto key."
  type        = string
}
