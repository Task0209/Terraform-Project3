resource "aws_launch_configuration" "impex-servers" {
  name_prefix   = "Dev-"
  image_id      = var.amitype
  instance_type = var.instancetype
  key_name      = aws_key_pair.tf-key-pair.key_name
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.impex-aus-ec2-iam-profile.name
  security_groups = [aws_security_group.impex_sg.id]
  

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

  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_autoscaling_group" "impex-servers" {
  name                 = "dev_asg"
  launch_configuration = aws_launch_configuration.impex-servers.name
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  vpc_zone_identifier  = [aws_subnet.subnet_impex_aus.id]

  tags = [
    {
      key                 = "Name"
      value               = "${var.instance_name}"
      propagate_at_launch = true
    },
  ]

  }

# Policy for Scaling up the Server
resource "aws_autoscaling_policy" "impex-cpu-up-policy"{
    name = "impex-cpu-up-policy"
    autoscaling_group_name = aws_autoscaling_group.impex-servers.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    cooldown = 300
    policy_type = "SimpleScaling"
}

# Policy for Scaling down the Server
resource "aws_autoscaling_policy" "impex-cpu-down-policy"{
    name = "impex-cpu-down-policy"
    autoscaling_group_name = aws_autoscaling_group.impex-servers.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    cooldown = 300
    policy_type = "SimpleScaling"
}