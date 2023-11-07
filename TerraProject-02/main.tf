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
  user_data              = "${file("docker.sh")}"

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




# VPC
resource "aws_vpc" "vpc_impex_aus" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-impex-aus-vpc"
    Environment = var.environment
  }
}

# Subnet
resource "aws_subnet" "subnet_impex_aus" {
  vpc_id                  = aws_vpc.vpc_impex_aus.id
  cidr_block              = var.subnet_impex_aus_cidr
  availability_zone       = local.availability_zones
  

  tags = {
    Name        = "${var.environment}-impex-aus-subnet"
    Environment = var.environment
  }
}

#Internet gateway
resource "aws_internet_gateway" "ig_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id
  tags = {
     Name        = "${var.environment}-impex-aus-igw"
     Environment = var.environment
  }
}

# Elastic-IP (eip) 
resource "aws_eip" "eip_impex_aus" {
  vpc     = true
  depends_on = [aws_internet_gateway.ig_impex_aus]
  instance = aws_instance.Impex_server.id
}

# Elastic IP association
resource "aws_eip_association" "eip_assoc_impex_aus" {
  instance_id   = aws_instance.Impex_server.id
  allocation_id = aws_eip.eip_impex_aus.id
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "rt_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id

  tags = {
    Name        = "${var.environment}-impex-aus-route-table"
    Environment = var.environment
  }
}

# Route for Internet Gateway
resource "aws_route" "route_impex_aus" {
  route_table_id         = aws_route_table.rt_impex_aus.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig_impex_aus.id
}

# Route table associations for both Public subnet
resource "aws_route_table_association" "rta_impex_aus" {
  subnet_id      = aws_subnet.subnet_impex_aus.id
  route_table_id = aws_route_table.rt_impex_aus.id
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

# Create IAM Roles

resource "aws_iam_instance_profile" "impex-aus-ec2-iam-profile" {
name = "ec2_profile"
role = aws_iam_role.impex-aus-ec2-iam-role.name
}

resource "aws_iam_policy" "impex-aus-ec2-iam-policy" {
  name = "ec2_policy"
  path = "/"
  description = "Policy to provide permission to EC2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:RunInstances",
          "ec2:AssociateIamInstanceProfile",
          "ec2:ReplaceIamInstanceProfileAssociation"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:ListInstanceProfiles",
          "iam:PassRole"
        ],
        Resource = "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "impex-aus-ec2-iam-role" {
  name = "ec2_role"
  description = "The role for the developer resources EC2"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_policy_attachment" "test-attachimpex-aus-ec2-iam-policy" {
  name      = "ec2-policy"
  roles     = [aws_iam_role.impex-aus-ec2-iam-role.name]
  policy_arn = aws_iam_policy.impex-aus-ec2-iam-policy.arn
}

