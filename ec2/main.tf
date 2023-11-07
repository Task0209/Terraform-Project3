
# Key Creation

resource "aws_key_pair" "impex-key-pair" {
key_name = "${var.key-name}"
public_key = tls_private_key.impex-rsa.public_key_openssh
}

resource "tls_private_key" "impex-rsa" {
algorithm = var.alg
rsa_bits  = var.bits
}

resource "local_file" "impex-key" {
content  = tls_private_key.impex-rsa.private_key_pem
filename = "${var.keyfilename}"
}

# EC2
resource "aws_instance" "Impex_server" {
  ami           = var.amitype
  instance_type = var.instancetype
  subnet_id                   = var.subnet1-id
  vpc_security_group_ids      = [var.sg_id]
  iam_instance_profile        = var.impex-profile
  associate_public_ip_address = true
  key_name      = aws_key_pair.impex-key-pair.key_name

  # root disk
  root_block_device {
    volume_size           = var.vol-size
    volume_type           = var.vol-type
    encrypted             = var.encryption
    delete_on_termination = var.del-termination
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "40"
    volume_type           = "gp2"
    encrypted             = var.encryption
    delete_on_termination = var.del-termination
  }


  tags = {
    Name = var.instance_name  # Will be used by backup_plan
  }
}



