resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
    alarm_name = "web_cpu_alarm_up"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "60"
    alarm_description = "Thie metric monitors ec2 cpu utilization"

    dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.test-server-asg.name
    }

    alarm_actions = [aws_autoscaling_policy.web_policy_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
    alarm_name = "web_cpu_alarm_down"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "10"
    alarm_description = "Thie metric monitors ec2 cpu utilization"

    dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.test-server-asg.name
    }

    alarm_actions = [aws_autoscaling_policy.web_policy_down.arn ]
}