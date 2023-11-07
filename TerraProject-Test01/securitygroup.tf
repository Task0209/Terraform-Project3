# Create security groups to allow specific traffic

resource "aws_security_group" "impex_sg" {
  name   = "impex_sg"
  vpc_id = aws_vpc.vpc_impex_aus.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
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