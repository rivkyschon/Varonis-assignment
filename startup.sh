# #!/bin/bash
# # Update and install Docker
# apt-get update && apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common \
#     docker.io

# # Add Docker to user group for non-root access
# usermod -aG docker jenkins

# # Install Jenkins
# curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
#   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
#   https://pkg.jenkins.io/debian binary/ | sudo tee \
#   /etc/apt/sources.list.d/jenkins.list > /dev/null
# apt-get update && apt-get install -y jenkins
#---------------------------------------------------------


#!/bin/bash
# Update and install Docker
apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    docker.io

# Add Docker to user group for non-root access
usermod -aG docker jenkins

# Install Docker Compose (optional, for managing multi-container setups)
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Pull the latest Jenkins Docker image
docker pull jenkins/jenkins:lts

# Create a directory for Jenkins data and JCasC configuration
mkdir -p /var/jenkins_home
mkdir -p /var/jenkins_config
chown -R 1000:1000 /var/jenkins_home
chown -R 1000:1000 /var/jenkins_config

# Create the jenkins.yaml configuration file
cat <<EOL > /var/jenkins_config/jenkins.yaml
jenkins:
  systemMessage: 'Jenkins configured with JCasC'
  securityRealm:
    local:
      allowsSignup: false
      users:
        - id: admin
          password: 1234 # Replace with your password
  authorizationStrategy:
    globalMatrix:
      permissions:
        - 'Overall/Administer:admin'
        - 'Overall/Read:authenticated'
EOL

# Run Jenkins container with JCasC configuration
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
    -v /var/jenkins_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/jenkins_config/jenkins.yaml:/var/jenkins_home/jenkins.yaml:ro \
    -e CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yaml \
    jenkins/jenkins:lts
#---------------------------------------------------------

