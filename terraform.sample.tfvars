# Project Configuration
project_id              = "your-project-id"
region                  = "your-region"

# VPC Configuration
vpc_name                = "your-vpc-name"
cloud_run_subnet_cidr   = "your-cloud-run-subnet-cidr"
lb_subnet_cidr          = "your-lb-subnet-cidr"

# Cloud Run Configuration
cloud_run_service_name  = "your-cloud-run-service-name"
cloud_run_image         = "gcr.io/your-project-id/your-image:tag"

# Load Balancer Configuration
load_balancer_name      = "your-load-balancer-name"
lb_name                 = "your-lb-name"

# Artifact Registry Configuration
location                = "your-location"
repository_id           = "your-repository-id"
kms_key_name            = "projects/your-project-id/locations/global/keyRings/your-kms-key"
writer_members          = ["serviceAccount:your-cloud-build-service-account@your-project-id.iam.gserviceaccount.com"]
reader_members          = ["serviceAccount:your-cloud-run-service-account@your-project-id.iam.gserviceaccount.com"]
members                 = ["serviceAccount:your-cloud-run-service-account@your-project-id.iam.gserviceaccount.com"]

# Organization and Billing Configuration
org_id                                      = "your-org-id"
parent_folder_id                            = "your-parent-folder-id"
billing_account                             = "your-billing-account"

# Access Context Manager Configuration
access_context_manager_policy_id            = "true/false"
access_level_members                        = ["user:your-email@your-domain.com"]
domain                                      = "your-domain.com"
create_access_context_manager_access_policy = true/false
