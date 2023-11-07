# VPC
resource "aws_vpc" "vpc_impex_book" {
  cidr_block           = var.vpc_cidr
  tags = {
    Name = "${var.vpc_name}"
  }
}

# Creating Subnets
# Subnet 1
resource "aws_subnet" "subnet1_impex_book" {
  vpc_id                  = aws_vpc.vpc_impex_book.id
  cidr_block              = var.subnet1_impex_cidr
  availability_zone       = var.azs
   tags = {
    Name = "${var.subnet1_name}"
  }
}

# Creating Gateways

#Internet gateway
resource "aws_internet_gateway" "ig_impex_book" {
  vpc_id = aws_vpc.vpc_impex_book.id
   tags = {
    Name = "${var.igw_name}"
  }
}

# Elastic-IP (eip) 
resource "aws_eip" "eip_impex_book" {
  domain   = var.domains
  depends_on = [aws_internet_gateway.ig_impex_book]
  instance = var.instance_id
}

# Elastic IP association
resource "aws_eip_association" "eip_assoc_impex_book" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.eip_impex_book.id
}


# Routing tables to route traffic for Subnet1
resource "aws_route_table" "rt1_impex_book" {
  vpc_id = aws_vpc.vpc_impex_book.id
   tags = {
    Name = "${var.rt1_name}"
  }
}


# Route for Internet Gateway
resource "aws_route" "route_impex_book_igw" {
  route_table_id         = aws_route_table.rt1_impex_book.id
  destination_cidr_block = var.des_cidr
  gateway_id             = aws_internet_gateway.ig_impex_book.id
}


# Route table associations for both subnet 1
resource "aws_route_table_association" "rta1_impex_book" {
  subnet_id      = aws_subnet.subnet1_impex_book.id
  route_table_id = aws_route_table.rt1_impex_book.id
}


# Create security groups to allow specific traffic

resource "aws_security_group" "impex_sg" {
  name   = "${var.sg_name}"
  vpc_id = aws_vpc.vpc_impex_book.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.des_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.des_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.des_cidr]
  }

  tags = {
    Name        = "${var.sg_name}"
  }
}