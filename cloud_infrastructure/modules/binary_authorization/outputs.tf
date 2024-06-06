output "attestor" {
  description = "The Binary Authorization attestor."
  value       = google_binary_authorization_attestor.attestor.name
}

output "policy" {
  description = "The Binary Authorization policy."
  value       = google_binary_authorization_policy.policy.name
}
