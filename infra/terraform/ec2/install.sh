#!/bin/bash
set -e  # Exit immediately if a command fails

# Function to log messages
log_message() {
    echo "[$(date)] $1"
}

# Install Docker
log_message "Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add user to Docker group for permissions
sudo usermod -aG docker ubuntu
newgrp docker  # Apply group changes without logging out

docker --version

# Install SonarQube as Docker container
log_message "Installing SonarQube..."
docker run -d --name sonar -p 9000:9000 --restart unless-stopped sonarqube:lts-community

# Install Trivy
log_message "Installing Trivy..."
sudo apt-get install -y wget apt-transport-https gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install trivy -y

# Install Java 17
log_message "Installing Java 17..."
sudo apt update -y
sudo apt install openjdk-17-jdk openjdk-17-jre -y
java -version

# Install Jenkins
log_message "Installing Jenkins..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins  # Enable Jenkins to start on boot

