############################################
# IAM Role for EC2
############################################

resource "aws_iam_role" "ec2_role" {
  name = "production-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

############################################
# Attach SSM Managed Policy
############################################

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

############################################
# CloudWatch Agent Policy
############################################

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

############################################
# IAM Instance Profile
############################################

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "production-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

############################################
# Bastion Host
############################################

resource "aws_instance" "bastion" {

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "production-bastion"
  }
}

############################################
# Private Application Server
############################################

resource "aws_instance" "application" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "production-app-server"
  }
}
