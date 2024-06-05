# outputs.tf

output "key_name" {
  value = google_kms_crypto_key.key.name
}
