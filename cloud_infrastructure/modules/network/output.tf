output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the created VPC."
}

output "cloud_run_subnet_id" {
  value       = google_compute_subnetwork.cloud_run_subnet.id
  description = "The ID of the Cloud Run subnet."
}

output "lb_subnet_id" {
  value       = google_compute_subnetwork.lb_subnet.id
  description = "The ID of the load balancer subnet."
}

# Add more outputs if needed for other network resources (e.g., firewall rules)
