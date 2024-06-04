# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"  # Or your preferred version
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
  connector_cidr_range    = var.connector_cidr_range # If using VPC Connector
}
