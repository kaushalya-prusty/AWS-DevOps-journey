# Project-2: Bastion Host + NAT Gateway + Private Web Server on AWS

## 📌 Objective

Set up a **secure 2-tier architecture** on AWS:

- Public Subnet → Bastion Host + NAT Gateway
- Private Subnet → Web Server (httpd)
- Ensure private server access only via Bastion & NAT

---

## Architecture

- **VPC** with 2 subnets:
  - Public Subnet → Bastion Host, NAT Gateway
  - Private Subnet → Web Server
- **Route Tables**:
  - Public Route Table → `0.0.0.0/0` → Internet Gateway
  - Private Route Table → `0.0.0.0/0` → NAT Gateway
- **Security Groups**:
  - Bastion SG → SSH (22) from My IP
  - Private Web SG → HTTP (80) + SSH (22) only from Bastion SG
- **EC2 Instances**:
  - Bastion Host (Amazon Linux 2023, public IP)
  - Private Web Server (Amazon Linux 2023, no public IP)

---

## ⚙️ Steps

1. Created **VPC, IGW, Subnets, Route Tables**.
2. Launched **Bastion Host** in Public Subnet (with public IP).
3. Launched **Web Server** in Private Subnet (no public IP).
4. Configured **NAT Gateway** in public subnet for internet access.
5. Installed & started Apache HTTP server:

   ```bash
   vi papana.pem    --> copy paste the private key
   chmod 400 "papana.pem"
   ssh -i "papana.pem" ec2-user@10.0.1.202

   # connected to the private server

   sudo -i
   yum update -y
   yum install -y httpd
   cd /var/www/html
   vi index.html  -> gave sample code "Hello from Private Web Server via Bastion!"
   sudo systemctl start httpd
   sudo systemctl enable httpd
   ```

6. Verified access from Bastion: curl http://10.0.1.202

✅ Outcome

1. Web server is completely private (no direct internet access).
2. Only accessible through Bastion Host.
3. Internet access for package installation via NAT Gateway.
4. Architecture follows AWS best practices for secure setups.
