resource "google_cloud_run_service" "default" {
  name     = "sample-app"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image
      }
    }
    metadata {
      annotations = {
        "run.googleapis.com/ingress" = "internal"
        "binaryauthorization.googleapis.com/secure-mode" = "true"
      }
    }
  }

  depends_on = [
    google_binary_authorization_policy.policy
  ]
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.default.location
  project  = var.project_id
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
