locals {
  #input_file         = "conf.yaml"
  input_file_content = fileexists("conf.yaml") ? file("conf.yaml") : "NoInputFileFound: true"
  raw_settings  = yamldecode(local.input_file_content)
  settings = {
    inputs = tomap({
      for v in local.raw_settings.inputs : v.name => v.default
    })
  }
}

# VPC
resource "aws_vpc" "vpc_impex_aus" {
  cidr_block           = local.settings.inputs.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.settings.inputs.environment}-impex-aus-vpc"
    Environment = local.settings.inputs.environment
  }
}

# Subnet
resource "aws_subnet" "subnet_impex_aus" {
  vpc_id                  = aws_vpc.vpc_impex_aus.id
  cidr_block              = local.settings.inputs.subnet_impex_aus_cidr
  availability_zone       = local.settings.inputs.az
  

  tags = {
    Name        = "${local.settings.inputs.environment}-impex-aus-subnet"
    Environment = local.settings.inputs.environment
  }
}

#Internet gateway
resource "aws_internet_gateway" "ig_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id
  tags = {
     Name        = "${local.settings.inputs.environment}-impex-aus-igw"
     Environment = local.settings.inputs.environment
}
}


# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "rt_impex_aus" {
  vpc_id = aws_vpc.vpc_impex_aus.id

  tags = {
    Name        = "${local.settings.inputs.environment}-impex-aus-route-table"
    Environment = local.settings.inputs.environment
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
