# IAM Module

## Purpose
This module handles the IAM role assignments for various service accounts used in the DevConnect project.

## Files
- `main.tf`: Contains the IAM role assignment configurations.
- `outputs.tf`: Defines the outputs for this module.
- `variables.tf`: Defines the input variables for this module.

## Usage
To use this module, include it in your Terraform configuration as shown below:

```hcl
module "iam" {
  source     = "./modules/iam"
  project_id = var.project_id
}
```