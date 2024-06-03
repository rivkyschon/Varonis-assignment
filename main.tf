terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0" # Or the latest version
    }
  }
}

provider "google" {
  project = "varonis-assignment-425319" # Replace with your project ID
  region  = "me-west1" # Replace with your preferred region
}

resource "google_compute_instance" "jenkins_vm" {
  name         = "jenkins-instance"
  machine_type = "e2-medium" # Adjust as needed
  zone         = "me-west1-a" # Replace with your preferred zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Or your preferred image
    }
  }

  network_interface {
    network = "default"
    access_config {} # For external IP
  }

  metadata = {
    startup-script = file("startup.sh")
  }
}

resource "google_compute_firewall" "allow_jenkins" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080", "80", "443"] # Adjust as needed
  }

  source_ranges = ["0.0.0.0/0"]
}

output "instance_ip" {
  value = google_compute_instance.jenkins_vm.network_interface[0].access_config[0].nat_ip
}
