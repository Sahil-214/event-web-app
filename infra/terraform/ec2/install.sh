#!/bin/bash

# Update system and install Docker
sudo apt update -y
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add default user to the docker group (no need for sudo when using Docker)
sudo usermod -aG docker ubuntu

# Install Java for Jenkins
sudo apt install -y openjdk-17-jdk

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Run SonarQube using Docker
docker run -d --name sonarqube -p 9000:9000 sonarqube:latest

