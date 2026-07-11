#############################
# AWS
#############################

aws_region  = "ap-south-1"
environment = "production"

#############################
# Networking
#############################

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
private_subnet2_cidr = "10.0.3.0/24"

availability_zone  = "ap-south-1a"
availability_zone2 = "ap-south-1b"

#############################
# EC2
#############################

ami_id = "ami-0f58b397bc5c1f2e8"

instance_type = "t3.micro"

key_name = "production-key"

admin_ip = "10.0.1.20/32"

#############################
# Database
#############################

db_name = "productiondb"

db_username = "admin"

db_password = "ChangeMe@12345"
