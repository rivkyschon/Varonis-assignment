

resource "google_compute_instance" "bastion_host" {
  name         = "bastion-host"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public_subnet_a.name
    access_config {}
  }

  service_account {
    email  = "developer-sa@<PROJECT_ID>.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -yq openssh-server
  EOF

  tags = ["bastion"]
}
