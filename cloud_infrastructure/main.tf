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

