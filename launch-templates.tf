resource "aws_launch_template" "server-launch-template" {
  name_prefix            = "${var.main_project_tag}-server-lt-"
  image_id               = "${var.ec2-image-id}"
  instance_type          = "${var.ec2-instance-type}"
  key_name               = "${var.ec2-instance-key}"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id,aws_security_group.http-allow.id]

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      { "Name" = "${var.main_project_tag}-server" },
      { "Project" = var.main_project_tag }
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      { "Name" = "${var.main_project_tag}-server-volume" },
      { "Project" = var.main_project_tag }
    )
  }

  tags = merge(
    { "Name" = "${var.main_project_tag}-server-lt" },
    { "Project" = var.main_project_tag }
  )

  user_data = base64encode(templatefile("${path.module}/scripts/server.sh",{}))
}