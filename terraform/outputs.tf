############################################
# VPC
############################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

############################################
# Public Subnet
############################################

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}

############################################
# Private Subnet
############################################

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private.id
}

############################################
# Bastion Public IP
############################################

output "bastion_public_ip" {
  description = "Public IP of Bastion Host"
  value       = aws_instance.bastion.public_ip
}

############################################
# Application Private IP
############################################

output "application_private_ip" {
  description = "Private IP of Application Server"
  value       = aws_instance.application.private_ip
}

############################################
# RDS Endpoint
############################################

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.mysql.endpoint
}
