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

#module "kms" {
 # source     = "./modules/kms"
 # project_id = var.project_id
 # keyring    = "artifact_registry_kms"
 # key_name   = "my_artifact_registry_key"
 # location   = var.location
 # members    = ["rivky.schon@grunitech.com"]  # Add IAM policy bindings here if needed
#}

module "artifact_registry" {
  source            = "./modules/artifact_registry"
  location          = var.region 
  repository_id     = "my-docker-repo"  
  description       = "Docker repository for my secure web app"
  kms_key_name      = module.kms.key_name
}

module "cloud_run" {
  source  = "./modules/cloud_run"
  # insert the 5 required variables here
  access_level_members = ["rivky.schon@grunitech.com"]
  billing_account = "01C0B1-CE5636-3616F0"
  domain = "grunitech.com"
}
