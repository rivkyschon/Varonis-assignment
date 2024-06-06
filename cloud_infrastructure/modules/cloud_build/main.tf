resource "google_cloudbuild_trigger" "my_trigger" {
  name              = "my-cloudbuild-trigger"
  description       = "Trigger to run cloudbuild.yaml"

  trigger_template {
    branch_name     = "main" 
    repo_name       = "rivkyschon/Varonis-assignment"
  }

  filename          = "cloudbuild.yaml" 
  service_account   = data.google_service_account.cloud_build.email
}