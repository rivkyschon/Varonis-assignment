variable "key_ring_name" {
  description = "The name of the key ring"
  type        = string
}

variable "crypto_key_name" {
  description = "The name of the crypto key"
  type        = string
}

variable "location" {
  description = "The location for the KMS key ring"
  type        = string
}

variable "rotation_period" {
  description = "The rotation period for the crypto key"
  type        = string
  default     = "100000s"
}
