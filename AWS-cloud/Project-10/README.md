# 🚀 Terraform Project — Launching an EC2 Instance with Custom Networking

This project demonstrates how to automate the deployment of an **EC2 instance** on AWS using **Terraform**, while manually configuring all the required networking components — instead of relying on AWS defaults.

---

## 🏗️ **Project Overview**

The goal was to create a complete AWS setup using Terraform that includes:

- Custom **VPC**, **subnet**, **Internet Gateway**, and **route table**
- Custom **Security Group**
- **RSA key pair** generation and local storage
- An **EC2 instance** launched inside the custom VPC

---

## ⚙️ **Terraform Resources Used**

1. **Provider Configuration**
   ```hcl
   provider "aws" {
     region = "us-east-1"
   }
   ```

🖥️ How to Run
terraform init↵
terraform plan↵
-- aws configuration required to create ec2 through terrafom.
aws configure↵
Go to AWS account-> Security Credentials to get key
access keyid↵
secret access key id:↵
terraform apply↵

📸 Outcome

Successfully deployed an EC2 instance inside a custom VPC, configured with proper routing, key pair, and networking — all managed through Terraform.

🧠 Key Learnings

How to build a custom AWS network from scratch.
Automate EC2 provisioning with Terraform.
Generate and use RSA key pairs programmatically.
Understand Security Group flow and how each resource links together.
