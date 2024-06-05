output "repository_url" {
  value       = google_artifact_registry_repository.docker_repo.name
  description = "The full URL of the Artifact Registry repository."
}
