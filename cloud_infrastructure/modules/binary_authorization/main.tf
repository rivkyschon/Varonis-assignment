# Create Attestation Authority Note
resource "google_container_analysis_note" "attestation_note" {
  note_id = var.attestor_id
  project = var.project_id
  attestation_authority {
    hint {
      human_readable_name = "Attestor for container images"
    }
  }
}

# Create Attestor
resource "google_binary_authorization_attestor" "attestor" {
  name = var.attestor_id
  attestation_authority_note {
    note_reference = google_container_analysis_note.attestation_note.id
  }
}

# Binary Authorization Policy
resource "google_binary_authorization_policy" "policy" {
  project = var.project_id

  default_admission_rule {
    enforcement_mode = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    evaluation_mode  = "REQUIRE_ATTESTATION"
    require_attestations_by = [
      google_binary_authorization_attestor.attestor.name
    ]
  }

  global_policy_evaluation_mode = "ENABLE"
}



# Assign Roles to Cloud Build Service Account
data "google_project" "project" {
  project_id = var.project_id
}

data "google_service_account" "cloud_build" {
  project = var.project_id
  account_id = "cloud-build"
}

resource "google_project_iam_member" "cloud_build_artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_attestor_admin" {
  project = var.project_id
  role    = "roles/binaryauthorization.attestorAdmin"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}

resource "google_project_iam_member" "cloud_build_kms_signer" {
  project = var.project_id
  role    = "roles/cloudkms.signerVerifier"
  member  = "serviceAccount:${data.google_service_account.cloud_build.email}"
}
