#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

#Enable the following GCP APIs
#Cloud Build, Binary Authorization, On-Demand Scanning, Resource Manager API, Artifact Registry API, Artifact Registry Vulnerability Scanning, Cloud Deploy API, KMS API and Cloud Functions.
gcloud services enable cloudbuild.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable clouddeploy.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containeranalysis.googleapis.com
gcloud services enable binaryauthorization.googleapis.com


# Variables
PROJECT_ID=$(gcloud config get-value project)
SERVICE_ACCOUNT=$(gcloud projects describe $PROJECT_ID --format='get(projectNumber)')@cloudbuild.gserviceaccount.com

# Assign IAM roles to the Cloud Build service account
echo "Assigning IAM roles to the Cloud Build service account..."

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/artifactregistry.writer

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/containeranalysis.occurrences.viewer

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/clouddeploy.jobRunner

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/run.admin

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/binaryauthorization.attestorViewer

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$SERVICE_ACCOUNT \
  --role=roles/binaryauthorization.policyEditor

echo "IAM roles have been successfully assigned."

# Add any additional IAM roles for other service accounts as needed
# For example, if you have a service account for Cloud Run:
CLOUD_RUN_SA="your-cloud-run-sa@$PROJECT_ID.iam.gserviceaccount.com"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$CLOUD_RUN_SA \
  --role=roles/run.admin

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$CLOUD_RUN_SA \
  --role=roles/storage.admin

echo "Additional IAM roles have been successfully assigned."
