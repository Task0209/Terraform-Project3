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
