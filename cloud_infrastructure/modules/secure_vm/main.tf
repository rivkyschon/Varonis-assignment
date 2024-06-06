provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "vm_service_account" {
  account_id   = "vm-sa"
  display_name = "VM Service Account"
}

resource "google_project_iam_binding" "vm_sa_build" {
  role    = "roles/cloudbuild.builds.editor"
  members = ["serviceAccount:${google_service_account.vm_service_account.email}"]
}

resource "google_project_iam_binding" "vm_sa_run" {
  role    = "roles/run.admin"
  members = ["serviceAccount:${google_service_account.vm_service_account.email}"]
}

resource "google_project_iam_binding" "vm_sa_artifact" {
  role    = "roles/artifactregistry.writer"
  members = ["serviceAccount:${google_service_account.vm_service_account.email}"]
}

resource "google_compute_instance" "secure_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    # No external IP
  }

  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys = "YOUR_USERNAME:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["allow-ssh"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-from-my-ip"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges

  target_tags = ["allow-ssh"]
}

resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = var.network
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name   = "nat"
  router = google_compute_router.nat_router.name
  region = var.region

  nat_ip_allocate_option         = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
