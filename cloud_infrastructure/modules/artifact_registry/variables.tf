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

variable "kms_key_id" {
  type        = string
  description = "The Cloud KMS key id for encrypting the repository data."
  default     = null  # Use Google-managed keys if not specified
}