resource "google_artifact_registry_repository" "docker_repo" {
  location    = var.location
  repository_id = var.repository_id
  description = var.description
  format      = "DOCKER"

  kms_key_name = "key_ring"
  depends_on = [
    google_kms_crypto_key_iam_member.crypto_key
  ]
}


resource "google_kms_crypto_key_iam_member" "crypto_key" {
  crypto_key_id = "key_ring"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "users:rivky.schon@grunitech.com"
}

