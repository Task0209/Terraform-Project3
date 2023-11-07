# Declare Local Variable for Retrieve the value from Yaml Input File

locals {
  config = yamldecode(file("conf1.yaml"))
}


# VPC
resource "aws_vpc" "vpc_impex_aus" {
  cidr_block           = local.config.vpc_cidr.default
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.config.environment.default}-impex-aus-vpc"
    Environment = local.config.environment.default
  }
}

# Subnet
resource "aws_subnet" "subnet_impex_aus" {
  vpc_id                  = aws_vpc.vpc_impex_aus.id
  cidr_block              = local.config.subnet_impex_aus_cidr.default
  availability_zone       = local.config.az.default
  

  tags = {
    Name        = "${local.config.environment.default}-impex-aus-subnet"
    Environment = local.config.environment.default
  }
}

#Internet gateway
resource "aws_internet_gateway" "ig_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id
  tags = {
     Name        = "${local.config.environment.default}-impex-aus-igw"
     Environment = local.config.environment.default
  }
}


# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "rt_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id

  tags = {
    Name        = "${local.config.environment.default}-impex-aus-route-table"
    Environment = local.config.environment.default
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
