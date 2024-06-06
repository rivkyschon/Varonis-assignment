resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false  # We'll create subnets explicitly
  routing_mode            = "GLOBAL" 
}

resource "google_compute_subnetwork" "cloud_run_subnet" {
  name          = "${var.vpc_name}-cloud-run-subnet"
  ip_cidr_range = var.cloud_run_subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
  private_ip_google_access = true 
  purpose      = "PRIVATE"
}

resource "google_compute_subnetwork" "lb_subnet" {
  name          = "${var.vpc_name}-lb-subnet"
  ip_cidr_range = var.lb_subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
}

