resource "google_cloud_run_service" "default" {
  name     = "hello"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.default.location
  project  = var.project_id
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}