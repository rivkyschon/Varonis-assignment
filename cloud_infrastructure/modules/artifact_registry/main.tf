resource "google_artifact_registry_repository" "docker_repo" {
  location    = var.location
  repository_id = var.repository_id
  description = var.description
  format      = "DOCKER"

#  kms_key_name = "key_ring"

}

