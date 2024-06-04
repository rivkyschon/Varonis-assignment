module "vpc" {
  source = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
  network_name = "my-vpc-network"
  subnets = [
    {
      subnet_name   = "subnet-1"
      subnet_ip     = "10.0.1.0/24"
      subnet_region = var.region
    },
    {
      subnet_name   = "subnet-2"
      subnet_ip     = "10.0.2.0/24"
      subnet_region = var.region
    }
  ]
}
