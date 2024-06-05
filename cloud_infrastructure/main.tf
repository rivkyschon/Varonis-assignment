# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
}

module "network" {
  source                 = "./modules/network"
  vpc_name               = var.vpc_name        # From your terraform.tfvars
  region                 = var.region           # From your terraform.tfvars
  cloud_run_subnet_cidr  = var.cloud_run_subnet_cidr 
  lb_subnet_cidr         = var.lb_subnet_cidr 
}

module "kms_key" {
  source = "terraform-google-modules/kms/google//modules/cryptokey"
  version = "2.3.0" // or latest version
  keyring = "artifact_registry_kms" // name for your keyring
  key_name = "my-artifact-registry-key" // name for the key
  key_rotation_period_seconds = 2592000 // optional, default 30 days
  purpose = "ASYMMETRIC_SIGN" 
  algorithm = "EC_SIGN_P256_SHA256" // recommended
  iam_members = [
    "serviceAccount:service-${data.google_project.project.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com"
  ]
}


module "artifact_registry" {
    depends_on = [
    module.kms_key
  ]
  source            = "./modules/artifact_registry"
  location          = var.region 
  repository_id     = "my-docker-repo"  
  description       = "Docker repository for my secure web app"
  kms_key_name      = module.kms_key.key_name
  writer_members    = var.writer_members
  reader_members    = var.reader_members
}