# ---------------- Assign Roles to Cloud Build Service Account -------------------

data "google_project" "project" {
  project_id = var.project_id
}

data "google_service_account" "cloud_build" {
  project    = var.project_id
  account_id = "cloud-build"
}

resource "google_project_iam_member" "cloud_build_artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_attestor_admin" {
  project = var.project_id
  role    = "roles/binaryauthorization.attestor"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_deploy_runner" {
  project = var.project_id
  role    = "roles/clouddeploy.jobRunner"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_kms_signer" {
  project = var.project_id
  role    = "roles/cloudkms.signerVerifier"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}


# ---------------- Assign Roles to Cloud Deploy Service Account -------------------


resource "google_cloud_run_service_iam_binding" "allow_cloud_deploy_access" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  role    = "roles/run.admin"
  members = [
    "serviceAccount:your-cloud-deploy-service-account@your-gcp-project-id.iam.gserviceaccount.com"
  ]
}

resource "google_cloud_run_service_iam_binding" "deny_all_users" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  role    = "roles/run.invoker"
  members = [
    "deleted:allUsers"
  ]
}