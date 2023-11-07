resource "aws_cloudwatch_metric_alarm" "impex-cpu-alarm-up" {
    alarm_name = "impex-cpu-alarm-up"
    alarm_description = "impex-alarm for scale up policy"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPU Utilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 60

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.impex-servers.name
    }

    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.impex-cpu-up-policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "impex-cpu-alarm-down" {
    alarm_name = "impex-cpu-alarm-down"
    alarm_description = "impex-alarm for scale down policy"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPU Utilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 10

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.impex-servers.name
    }

    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.impex-cpu-down-policy.arn]
}