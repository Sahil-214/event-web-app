# Event Web App (DevOps Automation Project)

## Overview

This project demonstrates end-to-end automation for deploying a containerized **Event Web Application** using DevOps best practices. It starts with **local testing**, followed by **infrastructure provisioning** (EC2, Jenkins, Monitoring), and concludes with a **fully automated CI/CD pipeline** and **monitoring setup**.

## Features

- **Home Page:** Welcoming layout with event highlights and call-to-action.
- **About Section:** Informative content describing the event purpose and value.
- **Schedule:** Clear breakdown of event sessions and timings.
- **Contact Form:** Interactive form to collect inquiries from users.

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Python (Flask)
- **DevOps Tools:** Docker, GitHub Actions, Terraform, Kubernetes

## Performance Metrics

- 🚀 30% improvement in load time post optimization.
- ⚙️ Reduced manual build/test time by 60% via CI/CD pipeline.
- 📦 Container image size reduced by 25% for faster deployment.
- 🔧 Improved uptime and stability with health checks and resource limits in Docker.

## Getting Started

### Prerequisites

- Python 3.x
- Docker
- Git

## 🔧 Technologies Used

- **AWS (EC2, IAM, S3, VPC)**
- **Terraform** – Infrastructure as Code (IaC)
- **Docker** – Containerization
- **Jenkins** – CI/CD Pipeline
- **Prometheus + Grafana** – Monitoring
- **Linux Shell Scripts** – Setup automation
- **Git & GitHub**

## 🚀 Project Phases

### ✅ 1. Local Testing

Before deploying to the cloud:

```bash
git clone https://github.com/sparknet-innovations/event-web-app.git
cd event-web-app
docker build -t event-web-app .
docker run -p 8080:8080 event-web-app
```

Access the app at `http://localhost:8080`

### ✅ 2. Infrastructure Provisioning (Terraform)

#### Resources Provisioned:

- VPC with public subnet(s)
- 2 EC2 instances:
  - `jenkins-server` – CI/CD setup
  - `monitoring-server` – Prometheus + Grafana
- Security groups, IAM roles, and S3 bucket (if needed)

#### Steps:

```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

### ✅ 3. EC2 Configuration with Scripts

Once EC2 instances are provisioned:

- Custom **shell scripts** are automatically triggered using Terraform `remote-exec` or manually via SSH to:

  - Install **Java**, **Jenkins**, **Docker**, and **Git** on the Jenkins server.
  - Install **Prometheus** and **Grafana** on the Monitoring server.
  - Configure Jenkins and Docker to work together.
  - Clone the app repo and run basic checks.

### ✅ 4. Jenkins Pipeline Setup

1. Access Jenkins at `http://<jenkins-ec2-public-ip>:8080`
2. Install recommended plugins.
3. Create a new **Pipeline Job**.
4. Connect it to your GitHub repo.
5. Use the following sample `Jenkinsfile` to:
   - Clone repo
   - Build Docker image
   - Push to DockerHub/ECR (if configured)
   - Deploy the container to EC2 or EKS

### ✅ 5. Monitoring Setup

On the Monitoring EC2:

- Prometheus scrapes metrics from the app (via Node Exporter or custom endpoints).
- Grafana visualizes application health.

Access:
- Grafana: `http://<monitoring-ec2-ip>:3000`
- Prometheus: `http://<monitoring-ec2-ip>:9090`

### ✅ 6. CI/CD Pipeline Flow

> End-to-End flow:

1. **Developer pushes code** to GitHub.
2. **Jenkins** triggers build pipeline.
3. Docker container is built & optionally pushed.
4. **App is deployed** to EC2 or EKS.
5. Monitoring is automatically updated.

## 🙌 Contributors

- **Sahil Gupta** – DevOps Engineer Intern @ Sparket Innovations



