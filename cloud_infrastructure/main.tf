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
  source                  = "./modules/network"
  vpc_name                = var.vpc_name
  region                  = var.region
  cloud_run_subnet_cidr   = var.cloud_run_subnet_cidr
  lb_subnet_cidr          = var.lb_subnet_cidr
}
