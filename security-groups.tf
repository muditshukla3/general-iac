# Security Group for SSH Connection
resource "aws_security_group" "ssh-sg" {

    vpc_id = aws_vpc.test-vpc.id
    name = "${var.main_project_tag}-ssh-sg"
    description = "Security group to allow SSH connection"

    tags = merge(
    { "Name" = "${var.main_project_tag}-ssh-sg" },
    { "Project" = var.main_project_tag }
  )
}

resource "aws_security_group_rule" "allow-ssh-sg-rule" {
   security_group_id = aws_security_group.ssh-sg.id
   type = "ingress"
   protocol = "tcp"
   from_port = 22
   to_port = 22
   cidr_blocks = var.allowed_cidr_blocks
   description = "Allow SSH Traffic"
}

# Security Group for HTTP Connection
resource "aws_security_group" "http-allow" {
  name_prefix = "${var.main_project_tag}-http-allow"
  description = "Firewall to allow http traffic only."
  vpc_id      = aws_vpc.test-vpc.id
  tags = merge(
    { "Name" = "${var.main_project_tag}-http-allow" },
    { "Project" = var.main_project_tag }
  )
}

resource "aws_security_group_rule" "tcp_allow_80" {
  security_group_id = aws_security_group.http-allow.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  source_security_group_id = aws_security_group.load_balancer.id
  description       = "Allow HTTP traffic."
}

resource "aws_security_group_rule" "tcp_allow_outbound" {
  security_group_id = aws_security_group.http-allow.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = var.allowed_cidr_blocks
  description       = "Allow any outbound traffic."
}

# Load balancer security group to allow HTTP traffic

resource "aws_security_group" "load_balancer" {
  name_prefix = "${var.main_project_tag}-alb-sg"
  description = "Firewall for the application load balancer."
  vpc_id      = aws_vpc.test-vpc.id
  tags = merge(
    { "Name" = "${var.main_project_tag}-alb-sg" },
    { "Project" = var.main_project_tag }
  )
}

resource "aws_security_group_rule" "load_balancer_allow_80" {
  security_group_id = aws_security_group.load_balancer.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = var.allowed_cidr_blocks
  description       = "Allow HTTP traffic."
}

resource "aws_security_group_rule" "load_balancer_allow_outbound" {
  security_group_id = aws_security_group.load_balancer.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = var.allowed_cidr_blocks
  description       = "Allow any outbound traffic."
}