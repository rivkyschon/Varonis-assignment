# Varonis Assignment

## Overview

This project sets up the secure infrastructure and deployment pipelines for the DevConnect application using Google Cloud Platform (GCP) and Terraform.

## Cloud Architecture
![image](https://github.com/rivkyschon/Varonis-assignment/assets/113901370/8d89705b-bf2a-4a99-88fa-dbc528715033)


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

## Technologies Used

- **Google Cloud Platform (GCP)**: Provides the cloud infrastructure for hosting and managing the application.
- **Terraform**: Infrastructure as Code (IaC) tool used for provisioning and managing cloud resources.
- **Cloud Build**: CI/CD service that builds, tests, and deploys containerized applications.
- **Artifact Registry**: Stores and manages container images and other artifacts.
- **Binary Authorization**: Ensures only trusted container images are deployed.
- **Cloud Deploy**: Automates the delivery of applications to GCP services.
- **Cloud Run**: Serverless compute platform for running containerized applications.
- **Cloud Armor**: Provides network security by protecting against DDoS and web attacks.
- **HTTPS Load Balancing**: Distributes incoming traffic across multiple backend services securely.
- **IAM (Identity and Access Management)**: Manages access to resources securely.
- **Cloud KMS (Key Management Service)**: Manages cryptographic keys for data encryption.
- **Logging**: Captures and stores log data for monitoring and troubleshooting.

## Project Workflow

1. **Source Code Management**: Developers commit code to a GitHub repository.
2. **Trigger CI Pipeline**: A new commit triggers the Cloud Build pipeline.
3. **Cloud Build Pipeline**:
   - **Static Code Analysis**: Ensures code quality and security.
   - **Build Docker Image**: Creates a container image from the application code.
   - **Scan Image for Vulnerabilities**: Checks the container image for known vulnerabilities.
   - **Push Image to Artifact Registry**: Stores the container image in the Artifact Registry.
   - **Attest Docker Image**: Uses Binary Authorization to verify and attest the image.
   - **Create Cloud Deploy Release**: Prepares the release for deployment.
4. **Cloud Deploy**: Deploys the application to Cloud Run.
5. **Cloud Run**: Runs the containerized application in a serverless environment.
6. **HTTPS Load Balancing**: Distributes incoming HTTPS traffic securely.
7. **Cloud Armor**: Protects the application from network-based threats.
8. **IAM**: Manages access permissions for various services.
9. **Logging**: Collects logs for monitoring and troubleshooting.
10. **Compute Engine (Jump Host)**: Provides a secure access point for managing instances in the private subnet.

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
