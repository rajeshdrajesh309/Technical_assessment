#############################
# AWS Configuration
#############################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

#############################
# Networking
#############################

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}

variable "private_subnet2_cidr" {
  description = "Second Private Subnet CIDR"
  type        = string
}

variable "availability_zone" {
  description = "Primary Availability Zone"
  type        = string
}

variable "availability_zone2" {
  description = "Secondary Availability Zone"
  type        = string
}

#############################
# EC2
#############################

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 Key Pair"
  type        = string
}

variable "admin_ip" {
  description = "Administrator Public IP"
  type        = string
}

#############################
# Database
#############################

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_username" {
  description = "Database Username"
  type        = string
}

variable "db_password" {
  description = "Database Password"
  type        = string
  sensitive   = true
}
