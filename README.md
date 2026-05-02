\# 🚀 Terraform AWS Multi-Environment Infrastructure (IaC)



This project implements a \*\*production-style AWS infrastructure using Terraform\*\*, supporting multiple environments (\*\*dev / staging / prod\*\*) with modular design, remote state management, and automated provisioning.



\---



\## 🧱 Architecture Overview



The infrastructure includes:



\- Custom \*\*VPC per environment\*\*

\- Public and Private \*\*Subnets\*\*

\- \*\*Internet Gateway (IGW)\*\*

\- \*\*NAT Gateway (for production private subnet access)\*\*

\- \*\*EC2 instances (multi-instance per environment)\*\*

\- \*\*Security Groups (Web, App, DB layers)\*\*

\- \*\*Elastic IPs\*\*

\- \*\*Remote backend (S3)\*\*

\- \*\*State locking (DynamoDB)\*\*



\---



\## 📁 Project Structure



terraform-aws-multi-env-iac/

│

├── environments/

│   ├── dev/

│   ├── staging/

│   └── prod/

│

├── modules/

│   ├── vpc/

│   ├── ec2/

│   └── security-groups/

│

├── scripts/

│   ├── deploy.ps1

│   ├── destroy-all.ps1

│   └── update-ssh-key.ps1

│

├── .gitignore

└── README.md





\---



\## ⚙️ Features



\### 🌍 Multi-Environment Support

\- Isolated environments: `dev`, `staging`, `prod`

\- Each environment has its own state file in S3



\### 🧩 Modular Design

\- Reusable Terraform modules:

&#x20; - VPC module

&#x20; - EC2 module

&#x20; - Security Groups module



\### ☁️ Remote Backend

\- S3 bucket for Terraform state storage

\- DynamoDB for state locking



\### 🔐 Security

\- Security Groups for:

&#x20; - Web tier (HTTP/HTTPS/SSH)

&#x20; - App tier (8080)

&#x20; - DB tier (3306 / 5432)

\- SSH key-based access



\---



\## 🚀 Deployment Workflow



\### 1️⃣ Initialize Terraform

```bash

cd environments/dev

terraform init



2️⃣ Plan Deployment

.\\scripts\\deploy.ps1 -Environment dev -Action plan

3️⃣ Apply Infrastructure

.\\scripts\\deploy.ps1 -Environment dev -Action apply

4️⃣ Get Outputs

.\\scripts\\deploy.ps1 -Environment dev -Action output

📤 Example Outputs

EC2 Instance IDs

Public IPs

Elastic IPs

SSH command

VPC ID

Subnet IDs



Example SSH access:



ssh -i $env:USERPROFILE\\.ssh\\terraform\_key ec2-user@52.200.68.184

🧪 AWS Resources Created

Resource	Description

VPC	Isolated network per environment

Subnets	Public \& Private

EC2	Application servers

NAT Gateway	Internet access for private subnets (prod)

IGW	Internet access for public subnets

Security Groups	Network security rules

Elastic IP	Static public IPs

⚠️ Notes

Use Free Tier eligible instances (e.g. t2.micro)

Avoid exceeding Elastic IP limits

Ensure correct CIDR configuration

🧹 Git Best Practices



Excluded via .gitignore:



.terraform/

\*.tfstate

\*.tfstate.backup

.env

.pem

📊 Technologies Used

Terraform

AWS (EC2, VPC, NAT, IAM, SG)

S3 Backend

DynamoDB Locking

PowerShell Automation

👨‍💻 Author



Abdelatif Mohamed



DevOps / Cloud Infrastructure Engineer

AWS • Terraform • Kubernetes • Automation



