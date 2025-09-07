# Project-5: Auto Scaling with Monitoring + Stress Testing

## 📝 Project Overview

This project demonstrates how to build a **highly available and scalable infrastructure** in AWS using VPC, EC2 Launch Templates, Auto Scaling Groups, and Load Balancers. It also includes real-time monitoring using Amazon CloudWatch, system-level monitoring via Mobaxterm, and stress testing to simulate load.

## 🚀 Architecture Overview

- VPC with 2 Public and 2 Private Subnets (spread across 2 AZs for HA).
- Internet Gateway (IGW) and NAT Gateway for secure internet access.
- Security Groups (SGs) to tightly control inbound/outbound traffic.
- Bastion Host (EC2 in public subnet) to securely access private EC2 instances.
- **Launch Template** (EC2-Template) defining configuration for private EC2s.
- Target Group associated with EC2 instances.
- Application Load Balancer (ALB) distributing traffic to the Auto Scaling Group.
- private Ec2 spins up through **Auto Scaling group**.

## Auto Scaling Group (ASG):

- Minimum: 1 EC2 instances
- Desired: 1 EC2 instances
- Maximum: 4 EC2 instances
- Scaling policies based on CPU Utilization thresholds

### ⚙️ Monitoring

# Amazon CloudWatch:

- Monitored CPU utilization metrics across Auto Scaling instances.
- Verified that new instances spin up when CPU crosses threshold.

# System Monitoring (Mobaxterm):

- Connected via Bastion Host.
- Used **top command** to monitor CPU usage in real-time.
- Verified scaling events correspond with system utilization.

## 🔥 Stress Testing

- To simulate real-world traffic and trigger scaling events, I used the stress tool:
  ``bash
  yum update -y
  yum install stress -y

# Simulate 2 CPU workers for 5 minutes

stress --cpu 2 --timeout 300s

- This artificially increased CPU utilization, allowing me to observe:
- Instances crossing the CPU threshold in CloudWatch
- Auto Scaling Group spinning up new EC2s (scale out)
- Scaling back down after CPU load decreased (scale in)

## 🔐 Security

- Bastion Host as the single entry point for SSH access.
- Private EC2s never exposed to the internet.
- Security Groups restrict traffic to only necessary ports and sources.

## 🏆 Outcome

- Successfully implemented Auto Scaling based on CPU utilization.
- Infrastructure can dynamically scale out/in depending on workload.
- Ensured high availability, fault tolerance, monitoring visibility, and load testing.
