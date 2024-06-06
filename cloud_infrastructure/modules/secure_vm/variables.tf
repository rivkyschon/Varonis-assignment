variable "project_id" {
  description = "The ID of the project in which to create resources."
  type        = string
}

variable "region" {
  description = "The region in which to create resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which to create resources."
  type        = string
  default     = "us-central1-a"
}

variable "network" {
  description = "The name of the VPC network to deploy resources."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "The name of the subnetwork to deploy resources."
  type        = string
  default     = "default"
}

variable "vm_name" {
  description = "The name of the VM instance."
  type        = string
  default     = "secure-vm"
}

variable "machine_type" {
  description = "The machine type to use for the VM instance."
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "The image to use for the VM instance."
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "ssh_source_ranges" {
  description = "The IP ranges that are allowed to SSH into the VM."
  type        = list(string)
  default     = ["YOUR_IP_ADDRESS/32"]
}
