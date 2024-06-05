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
  source  = "terraform-google-modules/kms/google//examples/simple_example"
  version = "2.3.0"
  keyring = "artifact_registry_kms"
  project_id = "varonis-assignment-425319"
}

module "artifact_registry" {
  source            = "./modules/artifact_registry"
  location          = var.region 
  repository_id     = "my-docker-repo"  
  description       = "Docker repository for my secure web app"
  kms_key_name      = var.kms_key_name
  writer_members    = var.writer_members
  reader_members    = var.reader_members
}