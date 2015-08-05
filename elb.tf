resource "aws_elb" "elb" {
  name = "${var.stack_name}"

  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8000/_healthcheck"
    interval = 10
  }

  subnets = ["${split(",", var.subnet_ids)}"]
  security_groups = ["${aws_security_group.elb_security_group.id}"]
  internal = true
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 60
}

resource "aws_security_group" "elb_security_group" {
  name = "${var.stack_name}_elb_security_group"

  vpc_id = "${var.vpc_id}"
  
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}