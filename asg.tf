# ASG for the Servers
resource "aws_autoscaling_group" "test-server-asg" {
	name_prefix = "${var.main_project_tag}-server-asg-"

	launch_template {
    id = aws_launch_template.server-launch-template.id
    version = aws_launch_template.server-launch-template.latest_version
  }

	target_group_arns = [aws_alb_target_group.group.arn]

	desired_capacity = var.server_desired_count
  min_size = var.server_min_count
  max_size = var.server_max_count

	# AKA the subnets to launch resources in 
  vpc_zone_identifier = aws_subnet.public.*.id

  health_check_grace_period = 300
  health_check_type = "EC2"
  termination_policies = ["OldestLaunchTemplate"]
  wait_for_capacity_timeout = 0
  tag {
    key = "Name"
    value = "${var.main_project_tag}-server"
    propagate_at_launch = true
  }
  tag {
    key = "Project"
    value = var.main_project_tag
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name = "web_policy_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.test-server-asg.name
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name = "web_policy_down"
  scaling_adjustment = -1

  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.test-server-asg.name
}