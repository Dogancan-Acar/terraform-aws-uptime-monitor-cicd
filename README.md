# Fully Automated AWS CI/CD Pipeline & Dockerized FastAPI Uptime Monitor


This project showcases an end-to-end, production-ready Cloud and DevOps architecture. It features a custom-built Python FastAPI application (Uptime Monitor) that is fully containerized (Dockerized) and autonomously deployed to AWS via a robust GitHub Actions CI/CD pipeline using Terraform for Infrastructure as Code (IaC).

## 🌟 Core Highlights

### 1. The Custom API & Containerization (Docker)
Instead of deploying a generic application, a custom **FastAPI Uptime Monitor** was developed to track website health. To ensure absolute environment consistency between development and production, the application was **Dockerized**. It is packaged into a lightweight, standalone Docker image, allowing it to run flawlessly on any environment with a single command.

### 2. The Power of CI/CD & Automation
The heart of this project is its zero-touch deployment model. The GitHub Actions pipeline is configured to listen for changes on the `main` branch. Upon a push:
* A runner is instantly spun up.
* AWS credentials are securely fetched from GitHub Secrets.
* Terraform initializes with a highly secure **AWS S3 Remote Backend** (preventing state loss).
* Infrastructure is provisioned/updated autonomously, and the EC2 instance pulls and runs the custom Docker image automatically upon booting.

## 🏗️ Architecture Flow

`GitHub Push ➔ GitHub Actions ➔ Terraform ➔ AWS EC2 ➔ Docker ➔ FastAPI`

## 🛠️ Tech Stack

* **Cloud Infrastructure:** AWS (EC2, S3 for Remote State, Security Groups)
* **Infrastructure as Code (IaC):** Terraform
* **Continuous Integration & Deployment:** GitHub Actions
* **Containerization:** Docker
* **Software Engineering:** Python, FastAPI, Uvicorn

## 📸 Project Proofs & Live System

*Visual evidence of the automated CI/CD pipeline and the deployed Docker container:*

### 1. Autonomous CI/CD Pipeline (GitHub Actions)
*(Terraform seamlessly planning and applying infrastructure changes)*
<img width="1920" height="1080" alt="Screenshot from 2026-03-03 00-55-24" src="https://github.com/user-attachments/assets/cb538963-d7cb-4b96-a1a5-286fd31364b6" />


### 2. Live Dockerized FastAPI on AWS EC2
*(The Uptime Monitor API successfully running and serving traffic*
<img width="1920" height="1080" alt="Screenshot from 2026-03-03 00-56-42" src="https://github.com/user-attachments/assets/f94c1d3a-5982-4271-8726-4ec6f8ce4150" />


## ⚙️ How It Works (Step-by-Step Execution)

If you want to reproduce this architecture, the pipeline handles the heavy lifting. Here is the exact flow of the system:

1. **Configure Secrets:** Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in your GitHub Repository Secrets.
2. **Trigger the Pipeline:** Push any code change to the `main` branch.
3. **Infrastructure Provisioning:** GitHub Actions triggers Terraform. Terraform creates an S3 bucket (if not exists for state lock), an EC2 instance (`eu-central-1`), and configures the necessary Security Groups (opening ports 22 and 8080).
4. **Bootstrap & Deployment:** During the EC2 instance creation, Terraform executes a `user_data` script that:
   * Updates the Ubuntu OS.
   * Installs Docker automatically.
   * Pulls the custom FastAPI Docker image.
   * Runs the container, mapping port 8080 to the host.
5. **Access the Application:** Once the pipeline turns green, simply visit `http://<EC2_PUBLIC_IP>:8080/docs` in your browser to interact with the live Swagger UI.

## 💡 Key Engineering Practices

* **Immutable Infrastructure:** EC2 instances are never configured manually via SSH. Everything is strictly bootstrapped via Terraform `user_data`.
* **Remote State Management:** The `terraform.tfstate` is securely locked in an AWS S3 Bucket, eliminating local dependency
* **Cost Optimization:** Infrastructure can be easily spun down using `terraform destroy -target`, while the critical S3 state bucket is protected by a `prevent_destroy = true` lifecycle rule to retain the architectural memory.

---
*Architected and Developed by [Doğancan Acar](https://www.linkedin.com/in/do%C4%9Fancan-acar-31a4ba284/)*
