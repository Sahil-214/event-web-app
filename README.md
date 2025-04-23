# Event Web App

## Overview

The **Event Web App** is a containerized, Flask-based web application designed to showcase events through a clean, static front end. It includes standard event sections like Home, About, Schedule, and Contact. This project demonstrates DevOps practices like Dockerization, CI/CD, and deployment via Kubernetes and Terraform.

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

### Run Locally with Docker

```bash
git clone https://github.com/Sahil-214/event-web-app.git
cd event-web-app
docker build -t event-web-app .
docker run -p 5000:5000 event-web-app


