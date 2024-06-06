# Varonis Assignment

## Overview
This project sets up the infrastructure and deployment pipelines for the DevConnect application using Google Cloud Platform (GCP) and Terraform.

## Project Structure
- `cloud_infrastructure/`
  - `modules/`
    - `artifact_registry/`
    - `binary_authorization/`
    - `cloud_build/`
    - `cloud_run/`
    - `compute_engine/`
    - `iam/`
    - `kms/`
    - `logging/`
    - `vpc/`
  - `main.tf`
  - `outputs.tf`
  - `providers.tf`
  - `terraform.tfvars`
  - `variables.tf`
- `django_web_app/`
- `docs/`
- `scripts/`
- `.config.yml`
- `.gcloudignore`
- `cloudbuild.yaml`
- `clouddeploy.yaml`
- `Dockerfile`
- `LICENSE`
- `README.md`
- `requirements.txt`

## Setup Instructions
1. Clone the repository:
    ```sh
    git clone https://github.com/your-repo/devconnect.git
    ```
2. Navigate to the project directory:
    ```sh
    cd devconnect
    ```
3. Initialize Terraform:
    ```sh
    terraform init
    ```
4. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```

## Modules
Each module in the `cloud_infrastructure/modules` directory has its own README file with specific details.

## Contributing
Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the `LICENSE` file for details.
