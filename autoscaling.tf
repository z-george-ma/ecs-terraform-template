resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${var.aws_region}a","${var.aws_region}b"]
  vpc_zone_identifier = ["${split(",", var.subnet_ids)}"]
  name = "${var.stack_name}"
  min_size = "${var.asg_min_size}"
  max_size = "${var.asg_max_size}"
  health_check_type = "${var.asg_health_check_type}"
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  load_balancers = ["${aws_elb.elb.id}"]
  
  tag {
    key = "Name"
    value = "${var.tag_name}"
    propagate_at_launch = true
  }
  
  tag {
    key = "Owner"
    value = "${var.tag_owner}"
    propagate_at_launch = true
  }
  
  tag {
    key = "Stream"
    value = "${var.tag_name}"
    propagate_at_launch = true
  }
  
  tag {
    key = "Project"
    value = "${var.tag_project}"
    propagate_at_launch = true
  }
}
