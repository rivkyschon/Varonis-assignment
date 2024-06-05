# variables.tf

variable "project_id" {
  description = "The ID of the project where the KMS key will be created"
}

variable "keyring" {
  description = "The name of the key ring to create"
}

variable "key_name" {
  description = "The name of the KMS key to create"
}

variable "location" {
  description = "The location (region) for the key ring"
}

variable "members" {
  description = "List of IAM policy bindings for the key"
  type        = list(string)
}
