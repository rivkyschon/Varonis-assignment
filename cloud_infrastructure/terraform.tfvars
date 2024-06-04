
project_id               = "varonis-assignment-425319"
region                   = "us-central1"
vpc_name                 = "secure-cloud-run-vpc"
cloud_run_subnet_cidr    = "10.0.1.0/24"
lb_subnet_cidr           = "10.0.2.0/24"
connector_cidr_range     = "10.8.0.0/28" # If using VPC Connector

# Cloud Run Variables (Examples - Adjust to your service)
cloud_run_service_name    = "my-cloud-run-service"
cloud_run_image          = "gcr.io/varonis-assignment-425319/your-image:tag"
cloud_run_container_port = 8080
cloud_run_memory         = "512Mi"

# Load Balancer Variables (Examples)
load_balancer_name      = "my-internal-lb"
load_balancer_type      = "INTERNAL_MANAGED"  # Or "INTERNAL_SELF_MANAGED"
cloud_armor_policy_name = "my-cloud-armor-policy"

# Cloud Armor Security Policy Rules (Example)
cloud_armor_rules = [
  {
    priority    = 1000
    action      = "deny(403)"
    expression  = "origin.region_code != 'US'"
    description = "Block traffic not originating from the US"
  },
  # ... other Cloud Armor rules
]
