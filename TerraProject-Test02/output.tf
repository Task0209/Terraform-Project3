output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc_impex_aus.id
}

output "route_table_id" {
  description = "Route Table ID"
  value       = aws_route_table.rt_impex_aus.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.subnet_impex_aus.id
}

output "gateway_id" {
  description = "Gateway ID"
  value       = aws_internet_gateway.ig_impex_aus.id
}

output "log" {
  value = "${yamldecode(file("test.yml"))["b"]}"
}


