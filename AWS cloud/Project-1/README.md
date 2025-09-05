# AWS Project 1: EC2 with HTTPD in Custom VPC

## 📌 Project Overview

This project demonstrates how to deploy a basic web server on an AWS EC2 instance inside a **custom VPC**. It covers networking setup, security configuration, and web server installation.

---

## 🛠️ Services & Tools Used

- **Amazon VPC** – Custom Virtual Private Cloud
- **Subnets** – Public subnet for EC2
- **Internet Gateway (IGW)** – To enable internet access
- **Route Table** – Configured to route traffic via IGW
- **Security Groups** – Allowed SSH (port 22) & HTTP (port 80)
- **EC2 Instance** – Amazon Linux 2
- **MobaXterm** – SSH client to connect to EC2
- **HTTPD Web Server** – Installed & configured

---

## ⚙️ Steps Implemented

1. Created a **VPC** with CIDR block `10.0.0.0/16`
2. Added a **public subnet** `10.0.1.0/24`
3. Attached an **Internet Gateway** to the VPC
4. Configured a **Route Table** to route internet traffic
5. Launched an **EC2 instance** inside the public subnet
6. Created a **Security Group** to allow:
   - SSH (22) from my IP
   - HTTP (80) from anywhere
7. Connected to EC2 using **MobaXterm** :connected through SSH, gave ec2 public IP and private key.
8. Installed HTTPD server:
   ```bash
   sudo -i
   yum update -y
   yum install -y httpd
   cd /var/www/html
   vi index.html  -> gave sample code
   sudo systemctl start httpd
   sudo systemctl enable httpd
   ```
9. Accessed the webpage via http://18.232.187.230
