# alb
resource "aws_alb" "alb" {
  name            = "alb"
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.load_balancer.id}"]
  subnets = aws_subnet.public.*.id

  tags = merge(
    { "Name" = "${var.main_project_tag}-alb" },
    { "Project" = var.main_project_tag }
  )
}

# target group
resource "aws_alb_target_group" "group" {
  name     = "alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test-vpc.id
  target_type = "instance"
  
  # Alter the destination of the health check to be the index page.
  health_check {
    path = "/index.html"
    port = 80
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}