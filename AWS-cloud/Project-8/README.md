# Project-8: IAM Best Practices with Secrets Manager Integration

## 📌 Overview

This project demonstrates **IAM best practices** on AWS with a focus on **secure access management**.  
We implemented **policies, roles, MFA, and Secrets Manager integration** to showcase how organizations can secure AWS resources and avoid hardcoding sensitive credentials.

---

## 🏗️ Architecture Flow

1. **VPC & EC2 Setup**

   - Created a secure VPC with subnets and EC2 instance.
   - Configured EC2 to use an **IAM role** instead of static access keys.

2. **IAM Best Practices**

   - Implemented the principle of **least privilege**.
   - Created IAM **policies** and attached them to roles (instead of users).
   - Enabled **MFA (Multi-Factor Authentication)** for additional security.
   - Avoided the use of **root account** for day-to-day operations.

3. **Secrets Manager Integration**

   - Stored sensitive data (e.g., DB password / API key) in **AWS Secrets Manager**.
   - Created an IAM Role with permission to access `secretsmanager:GetSecretValue`.
   - Attached this role to EC2 instance.
   - From EC2, retrieved the secret securely using AWS CLI:
     ```bash
     aws secretsmanager get-secret-value \
       --secret-id DB-passcode \
       --region us-east-1
     ```

4. **Security Validation**
   - Verified that only EC2 with the assigned IAM Role can fetch the secret.
   - Other users/instances without permission are denied access.

---

## 📊 Key Learnings

- ✅ Use **IAM Roles** instead of long-term credentials.
- ✅ Store secrets in **Secrets Manager** and fetch dynamically.
- ✅ Apply **least privilege** policies at all times.
