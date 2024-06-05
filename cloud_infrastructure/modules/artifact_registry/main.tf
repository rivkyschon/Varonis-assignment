resource "google_artifact_registry_repository" "docker_repo" {
  provider    = google-beta
  location    = var.location
  repository_id = var.repository_id
  description = var.description
  format      = "DOCKER"

  kms_key_name = var.kms_key_name
}


# IAM Policy for Artifact Registry
data "google_iam_policy" "artifact_registry_policy" {
  binding {
    role = "roles/artifactregistry.writer"

    members = [
      # Add the service accounts or groups that need write access
      var.writer_members,
    ]
  }

  binding {
    role = "roles/artifactregistry.reader"

    members = [
      # Add the service accounts or groups that only need read access
      var.reader_members,
    ]
  }
}

resource "google_artifact_registry_repository_iam_policy" "policy" {
  provider    = google-beta
  project     = google_artifact_registry_repository.docker_repo.project
  location    = google_artifact_registry_repository.docker_repo.location
  repository  = google_artifact_registry_repository.docker_repo.name
  policy_data = data.google_iam_policy.artifact_registry_policy.policy_data
}
