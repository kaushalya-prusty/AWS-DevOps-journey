# Project-3: Microservices Setup with Application Load Balancer (ALB) & Bastion Host

## 📌 Objective

To simulate a **microservices architecture** on AWS by deploying multiple web applications (Home, Mobile, Electronics) on private EC2 instances.  
The applications are accessed securely via an **Application Load Balancer (ALB)**, with a **Bastion Host** acting as the single entry point for SSH access.

---

## 🏗️ Architecture

- **VPC** with CIDR: `10.0.0.0/16`
- **Subnets**
  - 2 Public Subnets (for Bastion Host + ALB)
  - 3 Private Subnets (for Home, Mobile, Electronics applications)
- **Internet Gateway (IGW)** attached to VPC
- **NAT Gateway** in Public Subnet for Private EC2 internet access
- **Route Tables**
  - Public RT → IGW
  - Private RT → NAT Gateway
- **Security Groups**
  - Bastion Host SG → Allow SSH (22) from my IP
  - Private Web Server SG → Allow HTTP (80) + SSH (22) **only from Bastion SG**
  - ALB SG → Allow HTTP (80) from Anywhere, Forward traffic to Target Group

---

## ⚙️ Resources Created

1. **Bastion Host (Public EC2)**

   - Amazon Linux 2023
   - Connected via `.pem` key + SSH
   - Used to access private servers securely

2. **Private EC2 Instances (Microservices)**

   - `Home Service` (Private EC2)
   - `Mobile Service` (Private EC2)
   - `Electronics Service` (Private EC2)
   - Installed Apache (`httpd`) and deployed sample HTML pages under:
     - `/var/www/html/index.html`
     - `/var/www/html/mobile/index.html`
     - `/var/www/html/electronics/index.html`

3. **Application Load Balancer**
   - Created in Public Subnets
   - Listener: HTTP (80)
   - Target Groups:
     - `/` → Home EC2
     - `/mobile` → Mobile EC2
     - `/electronics` → Electronics EC2
   - Health Check paths updated accordingly:
     - `/`
     - `/mobile/`
     - `/electronics/`

---

## 🔑 Steps Performed

1. Created **VPC, Subnets, IGW, NAT Gateway, Route Tables**.
2. Launched **1 Public EC2 (Bastion Host)**.
3. Launched **3 Private EC2s (Home, Mobile, Electronics)**.
4. Configured **Security Groups**:
   - Bastion → SSH from my IP.
   - Private EC2 → HTTP (80) + SSH (22) only from Bastion.
   - ALB → HTTP (80) from Anywhere.
5. SSH into Bastion → then connected to private EC2 instances.
6. Installed Apache (`httpd`) & deployed **sample service pages**.
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

7. Created **Target Groups** & registered private EC2s.
8. Configured **Application Load Balancer**:
   - Forwarded requests `/`, `/mobile`, `/electronics`.
9. Verified access using **ALB DNS**:
   - `http://Home-LB-1932810778.us-east-1.elb.amazonaws.com`
   - `http://Home-LB-1932810778.us-east-1.elb.amazonaws.com/mobile`
   - `http://Home-LB-1932810778.us-east-1.elb.amazonaws.com/electronics`

---

## ✅ Output

- Access to **all 3 microservices** via single ALB DNS.
- Each service runs on a **separate private EC2** but exposed securely using ALB.
- Bastion Host ensures private servers are **not directly exposed** to the internet.

---

## 📸 Screenshots

- instances
- Target Groups
- Application deployment
- Load Balancer DNS → Accessing Home, Mobile, Electronics pages

---

## 📝 Learnings

- How to design a **multi-subnet VPC**.
- Using **Bastion Host** for secure access to private servers.
- Deploying **multiple apps (microservices)** behind ALB.
- Configuring **path-based routing** in ALB.
- Importance of correct **Security Group rules** for controlled access.

NLB-d0a94ea25246bc62.elb.us-east-1.amazonaws.com
