# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

resource "google_project_service" "enable_apis" {
  for_each = toset([
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
    "binaryauthorization.googleapis.com",
    "run.googleapis.com",
  ])
  project = var.project_id
  service = each.key
}

module "iam" {
  source     = "./modules/iam"
  project_id = var.project_id
}

module "vpc" {
  source                 = "./modules/vpc"
  vpc_name               = var.vpc_name
  region                 = var.region
  cloud_run_subnet_cidr  = var.cloud_run_subnet_cidr 
  lb_subnet_cidr         = var.lb_subnet_cidr 
}

module "kms" {
  source          = "./modules/kms"
  key_ring_name   = var.kms_key_ring_name
  crypto_key_name = var.kms_crypto_key_name
  location        = var.region
  rotation_period = var.kms_rotation_period
}

module "binary_authorization" {
  source          = "./modules/binary_authorization"
  project_id      = var.project_id
  location        = var.location
  attestor_id     = "cb-attestor"
  key_ring_name   = module.kms.key_ring_name
  crypto_key_name = module.kms.crypto_key_name
}

module "artifact_registry" {
  source            = "./modules/artifact_registry"
  location          = var.region 
  repository_id     = "my-docker-repo"  
  description       = "Docker repository for my secure web app"
  kms_key_id        =  module.kms.crypto_key_id
}

module "cloud_run" {
  image             = "us-central1-docker.pkg.dev/varonis-assignment-425319/my-docker-repo/sample-django-app:v0.0.0"
  cr_name           = var.cr_name
  source            = "./modules/cloud_run"
  region            = var.region
  project_id        = var.project_id
}

module "cloud_load_balancer" {
  source = "./modules/cloud_load_balancer"
  lb_name   = var.lb_name
  region = var.region
  domain = var.domain
  project_id = var.project_id
  cloud_run_service_name = module.cloud_run.cloud_run_service_name
}

module "cloud_build" {
  source = "./modules/cloud_build"
  region = var.region
  project_id = var.project_id
}

