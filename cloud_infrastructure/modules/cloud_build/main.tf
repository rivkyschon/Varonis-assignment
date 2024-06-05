terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloudbuild_trigger" "my_trigger" {
  name        = "my-cloudbuild-trigger"
  description = "Trigger to run cloudbuild.yaml"

  trigger_template {
    branch_name = "main"   // Or specify a different branch or tag
    repo_name   = "Varonis-assignment"
  }

  filename = "cloudbuild.yaml" 

  # service_account = "your-service-account-email" // Optional
}