resource "google_kms_key_ring" "key_ring" {
  name     = var.key_ring_name
  location = var.location
}

resource "google_kms_crypto_key" "crypto_key" {
  name            = var.crypto_key_name
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = var.rotation_period

  lifecycle {
    prevent_destroy = true
  }
}


output "crypto_key_id" {
  value = google_kms_crypto_key.crypto_key.id
}