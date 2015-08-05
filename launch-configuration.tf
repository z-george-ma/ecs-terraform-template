resource "aws_launch_configuration" "launch_configuration" {
    name = "${var.stack_name}"
    image_id = "${var.ami}"
    instance_type = "${var.instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.container_instance_iam_instance_profile.name}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.container_instance_security_group.id}"]
    user_data = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.ecs_cluster.name} > /etc/ecs/ecs.config"
}

resource "aws_iam_instance_profile" "container_instance_iam_instance_profile" {
    name = "${var.stack_name}_container_instance_iam_instance_profile"
    roles = ["${aws_iam_role.container_instance_iam_role.name}"]
}

resource "aws_iam_role" "container_instance_iam_role" {
  name = "${var.stack_name}_container_instance_iam_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "container_instance_iam_policy_attachment" {
    name = "${var.stack_name}_container_instance_iam_policy_attachment"
    roles = ["${aws_iam_role.container_instance_iam_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_security_group" "container_instance_security_group" {
  name = "${var.stack_name}_security_group"
  description = "Allow all inbound traffic"

  vpc_id = "${var.vpc_id}"
  
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
