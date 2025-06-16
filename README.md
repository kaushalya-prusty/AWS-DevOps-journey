# AWS-DevOps-journey

## Day 1: AWS EC2 with IAM role + S3 Static website Hosting + Terraform Setup

---

### ☁️ 1. EC2 Setup

- Launched EC2 instance (Amazon Linux 2)
- Connected via EC2 Instance Connect
- Explored basic CLI usage

📸 Screenshot:  
![EC2 Launch](./Day-1/screenshort/ec2-with-IAM-role.png.png)

---

### 📦 2. S3 Static Website Hosting

- Created S3 bucket: `kausalyabucket`
- Uploaded calculator app files (HTML, CSS, JS)
- Enabled static hosting and made files public

🔗 [Hosted Calculator App](http://kausalyabucket.s3-website.eu-north-1.amazonaws.com)  
📸 Screenshot:  
![S3 Static Hosting](./Day-1/screenshort/s3-static-hosted-calculator.png.png).png)

---

### 🛠️ 3. Terraform Installed

- Downloaded and installed Terraform (v1.8+)
- Verified installation with `terraform -v`
- Ready for Day 2: writing `.tf` files

📸 Screenshot:  
![Terraform Installed](./screenshots/terraform-install-success.png)
