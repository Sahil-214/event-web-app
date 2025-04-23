Event Web App
Overview
The Event Web App is a static web application developed using Python and Flask. It serves as a platform to showcase events in a professional and engaging manner. The application includes essential sections such as Home, About, Schedule, and Contact, ensuring a seamless user experience. The design emphasizes professionalism, ease of navigation, and visual appeal.​

Features
Home
Welcomes users with an engaging tagline and a call-to-action button.

Highlights the essence of the event to create a strong first impression.​

About
Provides a detailed overview of the event.

Explains the mission and key highlights of the event.​

Schedule
Displays the event agenda with time slots, session titles, and descriptions.

Designed for easy readability and clarity.​

Contact
Includes a contact form for inquiries.

Facilitates communication between attendees and organizers.​

Technologies Used
Frontend: HTML, CSS, JavaScript

Backend: Python, Flask

Containerization: Docker

CI/CD: GitHub Actions

Infrastructure as Code: Terraform

Orchestration: Kubernetes​

Performance Metrics
Achieved a 30% improvement in load time post-optimization.

Reduced manual build/test time by 60% through CI/CD pipeline integration.

Improved app stability and uptime by implementing health checks and resource limits.

Decreased container image size by 25% for faster deployment.​

Getting Started
Prerequisites
Python 3.x

Docker

Git​

Installation
Clone the repository:

bash
Copy
Edit
git clone https://github.com/Sahil-214/event-web-app.git
cd event-web-app
Build and run the Docker container:

bash
Copy
Edit
docker build -t event-web-app .
docker run -p 5000:5000 event-web-app
Access the application: Open your browser and navigate to http://localhost:5000.

Deployment
The application can be deployed using Kubernetes. Refer to the k8smanifest directory for Kubernetes deployment manifests. Terraform scripts for infrastructure provisioning are available in the infra/terraform directory.​

