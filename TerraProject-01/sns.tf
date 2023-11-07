resource "aws_sns_topic" "impex-cpu-sns" {
    name = "impex-sns-cpu"
    display_name = "impex-sns-cpu"
}

resource "aws_autoscaling_notification" "impex-notify" {
    group_names = [aws_autoscaling_group.impex-servers.name]
    topic_arn = aws_sns_topic.impex-cpu-sns.arn
    notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    ]
}