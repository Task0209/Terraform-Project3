# Declare Local Variable for Retrieve the value from Yaml Input File

locals {
  config = yamldecode(file("conf.yaml"))
}

# VPC
resource "aws_vpc" "vpc_impex_aus" {
  cidr_block           = local.config.vpc.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.config.environment.name}-impex-aus-vpc"
    Environment = local.config.environment.name
  }
}

# Subnet
resource "aws_subnet" "subnet_impex_aus" {
  vpc_id                  = aws_vpc.vpc_impex_aus.id
  cidr_block              = local.config.subnets.cidr
  availability_zone       = local.config.subnets.azs
  

  tags = {
    Name        = "${local.config.environment.name}-impex-aus-subnet"
    Environment = local.config.environment.name
  }
}

#Internet gateway
resource "aws_internet_gateway" "ig_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id
  tags = {
     Name        = "${local.config.environment.name}-impex-aus-igw"
     Environment = local.config.environment.name
}
}


# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "rt_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id

  tags = {
    Name        = "${local.config.environment.name}-impex-aus-route-table"
    Environment = local.config.environment.name
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
