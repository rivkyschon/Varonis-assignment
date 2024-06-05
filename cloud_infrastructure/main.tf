# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

resource "null_resource" "setup_iam_roles" {
  provisioner "local-exec" {
    command = "../setup_iam_roles.sh"
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
 # kms_key_name      = module.kms.key_name
}

module "cloud_run" {
  cr_name = "cr"
  source  = "./modules/cloud_run"
  region = var.region
  project_id = var.project_id
}


module "cloud_load_balancer" {
  source = "./modules/cloud_load_balancer"
  lb_name   = var.name
  region = var.region
  domain = var.domain
  project_id = var.project_id
}