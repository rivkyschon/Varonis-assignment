# main.tf

resource "google_kms_key_ring" "key_ring" {
  name     = var.keyring
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  name     = var.key_name
  key_ring = google_kms_key_ring.key_ring.self_link
  purpose  = "ENCRYPT_DECRYPT"
}

# Optionally, you can add IAM policy bindings for the key
resource "google_project_iam_binding" "kms_key_binding" {
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  
  members = var.members
}
