resource "aws_launch_template" "server-launch-template" {
  name_prefix            = "${var.main_project_tag}-server-lt-"
  image_id               = "ami-0ed9277fb7eb570c9"
  instance_type          = "t2.micro"
  key_name               = "Consul-S1"
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