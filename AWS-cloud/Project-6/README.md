# Project-6: VPC Peering (Inter-Region – Ohio ↔ California)

## 📌 Overview

This project demonstrates **VPC Peering across AWS regions**, enabling secure communication between resources in different VPCs and regions.  
We connected a **public EC2 instance in Ohio (us-east-2)** with a **private EC2 instance in California (us-west-1)** via VPC Peering and validated communication through a Bastion Host setup.

---

## 🏗️ Architecture Flow

1. **VPC Setup**

   - **Ohio Region (us-east-2)**:
     - VPC CIDR: `10.0.0.0/24`
     - 1 Public Subnet + EC2 instance (Public/Bastion host).
   - **California Region (us-west-1)**:
     - VPC CIDR: `192.168.0.0/24`
     - 1 Private Subnet + EC2 instance (Private server).

2. **VPC Peering Connection**

   - Established peering between **Ohio (10.0.0.0/24)** and **California (192.168.0.0/24)**.
   - Updated **Route Tables** on both sides to allow inter-VPC communication.

3. **Security Groups**

   - **Ohio EC2 (Public)**:
     - Inbound: SSH (22) from my IP, All traffic from California VPC (`192.168.0.0/24`).
   - **California EC2 (Private)**:
     - Inbound: SSH (22) + HTTP (80) from Ohio VPC (`10.0.0.0/24`).

4. **Connectivity**
   - SSH from **local machine → Ohio Public EC2 (Bastion)**.
   - From Bastion, SSH into **California Private EC2**.
   - Successfully validated communication across **inter-region peering**.

---

## ⚙️ Commands Used

```bash
# From Bastion → California Private EC2
ssh -i "papana3.pem" ec2-user@192.168.0.60

## 🔐 Key Learnings
- VPC Peering enables direct, secure connectivity between VPCs in different regions.
- Route tables + SG rules are critical for proper traffic flow.
- Bastion hosts provide a secure jump point for accessing private EC2s.
```
