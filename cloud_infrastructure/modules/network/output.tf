output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "cloud_run_subnet" {
  value = google_compute_subnetwork.cloud_run_subnet.name
}

output "lb_subnet" {
  value = google_compute_subnetwork.lb_subnet.name
}
