terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.aws_region
}

locals {
  availability_zones = "${var.aws_region}a"
}


# Key Creation

resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}

# EC2
resource "aws_instance" "Impex_server" {
  ami           = var.amitype
  instance_type = var.instancetype
  subnet_id                   = aws_subnet.subnet_impex_aus.id
  vpc_security_group_ids      = [aws_security_group.impex_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.impex-aus-ec2-iam-profile.name
  associate_public_ip_address = true
  key_name      = aws_key_pair.tf-key-pair.key_name

  # root disk
  root_block_device {
    volume_size           = "30"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "40"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }


  tags = {
    Name = var.instance_name
    backup = "true"  # Will be used by backup_plan
  }
}




# Create security groups to allow specific traffic

resource "aws_security_group" "impex_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.vpc_impex_aus.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-impex-aus-security-group"
    Environment = var.environment
  }
}

