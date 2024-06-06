# This script configures Firewall rules for Jump Host VM which is used by developers to deploy to cloud run production environment. 
# The script also assigns IAM roles to developers for accessing the GCP project.

# Allow egress to Artifact Registry
gcloud compute firewall-rules create allow-egress-artifact-registry \
    --direction=EGRESS \
    --priority=1000 \
    --network=VPC-NETWORK \
    --action=ALLOW \
    --rules=tcp:443 \
    --destination-ranges=ARTIFACT_REGISTRY_IP_RANGES

# Allow egress to Cloud Run
gcloud compute firewall-rules create allow-egress-cloud-run \
    --direction=EGRESS \
    --priority=1000 \
    --network=VPC-NETWORK \
    --action=ALLOW \
    --rules=tcp:443 \
    --destination-ranges=CLOUD_RUN_IP_RANGES

# Deny all other egress traffic
gcloud compute firewall-rules create deny-all-egress \
    --direction=EGRESS \
    --priority=2000 \
    --network=VPC-NETWORK \
    --action=DENY \
    --rules=all

# Allow internal subnet communication
gcloud compute firewall-rules create allow-internal-subnet \
    --direction=INGRESS \
    --priority=1000 \
    --network=VPC-NETWORK \
    --action=ALLOW \
    --rules=all \
    --source-ranges=YOUR_SUBNET_IP_RANGE



# -----------------  IAM Roles and Firewall Rules for Developer Access -----------------

# Create a security group for developers
gcloud compute firewall-rules create allow-developer-ssh \
    --direction=INGRESS \
    --priority=1000 \
    --network=VPC-NETWORK \
    --action=ALLOW \
    --rules=tcp:22 \
    --source-ranges=DEVELOPER_IP_RANGES

# Deny internet access to the VM
gcloud compute firewall-rules create deny-internet-access \
    --direction=INGRESS \
    --priority=2000 \
    --network=-VPC-NETWORK \
    --action=DENY \
    --rules=all \
    --source-ranges=0.0.0.0/0



# ----------------- Assigning Roles to Developers -----------------

# Grant developers the necessary IAM roles
gcloud projects add-iam-policy-binding PROJECT_ID \
    --member="user:developer@example.com" \
    --role="roles/compute.instanceAdmin.v1"

gcloud projects add-iam-policy-binding PROJECT_ID \
    --member="user:developer@example.com" \
    --role="roles/compute.osLogin"