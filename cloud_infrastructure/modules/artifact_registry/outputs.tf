output "repository_url" {
  value       = google_artifact_registry_repository.docker_repo.name
  description = "The full URL of the Artifact Registry repository."
}

output "repo_id" {
  description = "The ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.repo.id
}