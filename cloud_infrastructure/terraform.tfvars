project_id              = "varonis-assignment-425319" 
region                  = "us-central1"
vpc_name                = "secure-cloud-run-vpc"
cloud_run_subnet_cidr    = "10.0.1.0/24"
lb_subnet_cidr           = "10.0.2.0/24"
cloud_run_service_name  = "my-cloud-run-service"
cloud_run_image         = "gcr.io/varonis-assignment-425319/your-image:tag"
load_balancer_name      = "my-internal-lb"

#for artifact registry:
location        = "us-central1" 
repository_id   = "my-docker-repo" 
kms_key_name    = "projects/your-project-id/locations/your-region/keyRings/your-keyring/cryptoKeys/your-cmek-key"
writer_members  = ["serviceAccount:your-cloud-build-service-account@your-project-id.iam.gserviceaccount.com",]  
reader_members  = ["serviceAccount:your-cloud-run-service-account@your-project-id.iam.gserviceaccount.com",]

#