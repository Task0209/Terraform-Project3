output "vpc_name" {
  description = "Name of the VPC"
  value = aws_vpc.vpc_impex_book.tags
}

output "subnet1_name" {
  description = "Name of the SUBNET"
  value = aws_subnet.subnet1_impex_book.tags
}

output "subnet2_name" {
  description = "Name of the SUBNET"
  value = aws_subnet.subnet2_impex_book.tags
}

output "igw_name" {
  description = "Name of the Internet Gateway"
  value = aws_nat_gateway.ng_impex_book.tags
}

output "ngw_name" {
  description = "Name of the Internet Gateway"
  value = aws_internet_gateway.ig_impex_book.tags
}

output "eip_name" {
  description = "Name of the Elastic IP"
  value = aws_eip.eip_impex_book.tags
}

output "rt1_name" {
  description = "Name of the Route table 1"
  value = aws_route_table.rt1_impex_book.tags
}

output "rt2_name" {
  description = "Name of the Route table 2"
  value = aws_route_table.rt2_impex_book.tags
}

output "domains" {
    description = "VPC for Elastic IP"
    value = aws_eip.eip_impex_book.domain
 }


 output "sg_name" {
  description = "Name of the Security Group"
  value = aws_security_group.impex_sg.tags
}

 output "sg_id" {
  description = "ID of the Security Group"
  value = aws_security_group.impex_sg.id
}

output "subnet1-id" {
  description = "ID for subnet1"
  value = aws_subnet.subnet1_impex_book.id
}
