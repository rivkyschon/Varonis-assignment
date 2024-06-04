output "vpc_id" {
  value       = module.network.vpc_id
  description = "The ID of the created VPC."
}

output "cloud_run_service_url" {
  value       = module.cloud_run.service_url
  description = "URL of the deployed Cloud Run service."
}

output "load_balancer_ip" {
  value       = module.cloud_load_balancer.ip_address
  description = "IP address of the internal load balancer."
}
