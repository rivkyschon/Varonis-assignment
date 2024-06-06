# Secure VM Terraform Module

This Terraform module sets up a secure VM instance in Google Cloud Platform (GCP) with the following features:
- The VM is only accessible via SSH from a specified IP address.
- The VM does not have an external IP address but can access the internet via Cloud NAT.
- The VM has minimal permissions to interact with Cloud Build, Cloud Run, and Artifact Registry.

Ideal for using as a workstation during devlopment stages