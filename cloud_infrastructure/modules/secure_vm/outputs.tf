output "vm_instance_name" {
  description = "The name of the VM instance."
  value       = google_compute_instance.secure_vm.name
}

output "service_account_email" {
  description = "The email of the service account used by the VM."
  value       = google_service_account.vm_service_account.email
}
