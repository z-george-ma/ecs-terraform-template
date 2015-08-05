resource "aws_route53_record" "route53_record" {
  zone_id = "${var.route53_zone_id}"
  name = "${var.route53_alias_name}"
  type = "A"

  alias {
    name = "${aws_elb.elb.dns_name}"
    zone_id = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}