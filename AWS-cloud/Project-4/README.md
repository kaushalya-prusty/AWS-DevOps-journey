# Project-4: Microservices Architecture using ALB + NLB on AWS

## 📝 Project Overview

In this project,I built a **secure and scalable Microservices Architecture** on AWS.
I designed a multi-layer load balancing architecture using Application Load Balancer (ALB) and Network Load Balancer (NLB) inside AWS VPC.

The ALB handled path-based routing for private EC2 microservices (Home + Mobile), while the NLB served as the internet-facing entry point, forwarding traffic securely to the internal ALB.

- **Application Load Balancer (ALB)** – internal-facing
- **Network Load Balancer (NLB)** – internet-facing
- **Bastion Host** for secure SSH access
- **Public and Private Subnets** across multiple Availability Zones

The architecture ensures:

- Segregated public/private resources
- Secure access using Security Groups
- Load balancing at both **application (HTTP)** and **network (TCP)** layers

---

## 🔧 Architecture Components

1. **VPC Setup**

   - Created a custom VPC with CIDR block `10.0.0.0/16`
   - Configured:
     - **2 Public Subnets** (for Bastion Host)
     - **2 Private Subnets** (for application servers: Home & Mobile services)

2. **Networking**

   - **Internet Gateway (IGW):** Attached to VPC for internet connectivity
   - **NAT Gateway:** Deployed in a public subnet for outbound internet from private subnets
   - **Route Tables:**
     - Public Route Table → Subnets with IGW
     - Private Route Table → Subnets with NAT

3. **Security Groups**

   - **Bastion SG:** SSH (22) from my IP
   - **Private App SG (Home & Mobile):** Allowed HTTP (80) from ALB SG
   - **ALB SG:** Allowed HTTP (80) from within VPC
   - **NLB SG:** Allowed inbound traffic from internet (0.0.0.0/0) on port 80 → forwards to ALB

4. **Compute Resources**

   - **Bastion Host (Public EC2):** Used for secure SSH tunneling into private servers
   - **Private EC2 Instances:**
     - Home Service (EC2-1) → Hosted sample HTML page
     - Mobile Service (EC2-2) → Hosted sample HTML page

5. **Load Balancing**
   - **Application Load Balancer (ALB – Internal Facing):**
     - Target Group: `Home-TG` → Home EC2
     - Target Group: `Mobile-TG` → Mobile EC2
     - Routes HTTP traffic internally based on service
   - **Network Load Balancer (NLB – Internet Facing):**
     - Target Group: `ALB-TG`
     - Forwards requests from the internet to the internal ALB
     - Acts as the secure entry point

---

## ⚙️ Steps to Reproduce

1. **VPC & Subnets**

   - Create VPC, 2 public & 2 private subnets across different AZs

2. **Networking**

   - Attach IGW & create NAT Gateway
   - Configure route tables for public & private subnets

3. **EC2 Setup and configuration**

   - Launch Bastion Host in public subnet for SSH
   - Launch Home & Mobile EC2s in private subnets with Apache installed
   - Install & configure `httpd` with sample service pages
     -Installed & started Apache HTTP server:

   ```bash
   vi papana.pem    --> copy paste the private key
   chmod 400 "papana.pem"
   ssh -i "papana.pem" ec2-user@10.0.1.202

   # connected to the private servers

   sudo -i
   yum update -y
   yum install -y httpd
   cd /var/www/html
   vi index.html  -> gave sample code "This is home page."
   sudo systemctl start httpd
   sudo systemctl enable httpd

   ```

4. **Load Balancer Setup**

   - Create Internal ALB → attach Home & Mobile target groups
   - Create Internet-facing NLB → forward to ALB target group

5. **Testing**
   - Access application via NLB DNS name
   - Verify traffic routes correctly to Home/Mobile services

---

## ✅ Outputs

- **NLB DNS:** Accessible from internet
- **ALB:** Routes requests internally to correct service
- **Microservices running securely inside private subnets**

---

## 🚀 Key Learnings

- Difference between **NLB (Layer 4)** & **ALB (Layer 7)**
- Designing **multi-tier secure architectures**
- Importance of Security Groups & controlled access
- Microservices deployment using AWS primitives
