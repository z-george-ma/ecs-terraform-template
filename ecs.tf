resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.stack_name}"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.stack_name}_ecs_task_definition"
  container_definitions = "${var.ecs_task_definitions}"
}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.stack_name}_ecs_service"
  cluster = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
  desired_count = "${var.ecs_desired_count}"
  iam_role = "${aws_iam_role.ecs_service_iam_role.arn}"

  load_balancer {
    elb_name = "${aws_elb.elb.id}"
    container_name = "${var.ecs_container_name}"
    container_port = "${var.ecs_container_port}"
  }
}

resource "aws_iam_role" "ecs_service_iam_role" {
  name = "${var.stack_name}_ecs_service_iam_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "ecs_service_iam_policy_attachment" {
    name = "${var.stack_name}_ecs_service_iam_policy_attachment"
    roles = ["${aws_iam_role.ecs_service_iam_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}