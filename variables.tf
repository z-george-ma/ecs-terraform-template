variable "stack_name" {
  description = "The name of the stack"
}

variable "aws_key" {
  description = "The AWS access key ID"
}
variable "aws_secret" {
  description = "The AWS secret access key"
}

variable "aws_region" {
  default = "ap-southeast-2"
  description = "The region of AWS"
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "subnet_ids" {
  description = "The subnet ids"
}

variable "route53_zone_id" {
  description = "The zone ID of route53"
}

variable "route53_alias_name" {
  description = "The alias name of route53"
}

variable "asg_min_size" {
  default = "1"
  description = "Minimum number of instances to run in the group"
}

variable "asg_max_size" {
  default = "2"
  description = "Maximum number of instances to run in the group"
}

variable "asg_health_check_type" {
  default = "ELB"
  description = "The health check type for autoscale group"
}

variable "asg_health_check_grace_period" {
  default = "300"
  description = "Time after instance comes into service before checking health"
}

variable "tag_name" {
  default = ""
  description = "The Name tag"
}

variable "tag_owner" {
  default = ""
  description = "The Owner tag"
}

variable "tag_stream" {
  default = ""
  description = "The Stream tag"
}

variable "tag_project" {
  default = ""
  description = "The Project tag"
}

variable "ecs_task_definitions" {
  default = <<EOF
[
	{
		"name": "container-name",
		"image": "image-name",
		"cpu": 1024,
		"memory": 512,
		"links": [],
		"portMappings": [
			{
				"containerPort": 80,
				"hostPort": 8000
			}
		]
	}
]
EOF
  description = "The task definition for ECS cluster"
}

variable "ecs_desired_count" {
  default = 3
  description = "The desired count for AWS ECS service"
}

variable "ecs_container_name" {
  description = "The name for ECS container"
}

variable "ecs_container_port" {
  description = "The port for ECS container"
}

variable "ami" {
  default = "ami-73bfc549"
  description = "AMI id to launch, must be in the region specified by the region variable"
}

variable "instance_type" {
  default = "m3.medium"
  description = "Name of the AWS instance type"
}
