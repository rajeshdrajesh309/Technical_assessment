# DevOps Engineer Technical Assessment

## Overview

This repository contains the solution for the DevOps Engineer Technical Assessment.

The implementation includes:

- AWS production-aware architecture
- Infrastructure as Code using Terraform
- Linux operational health check script

---

## Architecture

The infrastructure includes:

- Amazon VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- Bastion Host
- EC2 Application Server
- Amazon RDS MySQL
- Security Groups
- IAM Role
- CloudWatch Monitoring

The design follows AWS security best practices by isolating backend resources inside a private subnet while exposing only the Bastion Host for administrative access.

---

## Design Decisions

### Networking

- Custom VPC
- One Public Subnet
- One Private Subnet
- Internet Gateway attached to VPC
- Public Route Table
- Private Route Table

Public Resources

- Bastion Host

Private Resources

- Application EC2
- Amazon RDS

---

### Security

Security Groups implement least privilege.

Bastion Host

- SSH (22) from Administrator IP

Application EC2

- SSH only from Bastion Host
- HTTP allowed internally

RDS

- MySQL Port 3306 only from Application EC2 Security Group

IAM Roles should be used instead of storing AWS credentials on instances.

---

### Secrets Management

Sensitive values are never hardcoded.

Terraform variables are used.

For production environments:

- AWS Secrets Manager
- AWS Systems Manager Parameter Store

are recommended.

---

### Monitoring

CloudWatch should monitor:

- CPU
- Memory
- Disk
- Network

CloudWatch Agent can be installed on EC2 for enhanced monitoring.

---

### Cost Optimization

To minimize cost:

- t3.micro EC2 instances
- db.t3.micro RDS
- gp3 storage
- Single Availability Zone
- No NAT Gateway
- No Multi-AZ deployment

To keep the solution cost-conscious, a NAT Gateway has not been provisioned. In a production environment, a NAT Gateway or appropriate VPC endpoints would be added to allow private instances to download packages and access AWS services.
---

## Terraform Components

Terraform provisions:

- VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- Security Groups
- Bastion Host
- Application EC2
- Amazon RDS
- IAM Role

---

## Prerequisites

- AWS CLI configured
- Terraform installed
- Existing EC2 Key Pair
- AWS Account

---

## Terraform Commands

Initialize

```bash
terraform init
```

Validate

```bash
terraform validate
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

---

## Variables

Configuration values are stored in:

terraform.tfvars

No sensitive values are hardcoded.

---

## Linux Script

The health_check.sh script performs:

- Disk Usage Check
- Memory Usage Check
- Docker Service Check
- Timestamped Logging
- Exit Status 1 when disk utilization exceeds 80%

Run:

```bash
chmod +x health_checks.sh
./health_checks.sh
```

---

## Assumptions

- AWS credentials are already configured
- Administrator public IP is updated
- Existing EC2 Key Pair is available

---

## Trade-offs

To keep the assessment concise:

- Single Availability Zone
- No Auto Scaling Group
- No Load Balancer
- No NAT Gateway
- No EKS Cluster
- Minimal RDS configuration

In production, these components would be added for high availability and scalability.
