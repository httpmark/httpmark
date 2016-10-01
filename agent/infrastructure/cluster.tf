provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "eu-west-1"
}

resource "aws_ecs_cluster" "default" {
  name = "test-agents-${var.environment}"
}

resource "aws_iam_role" "ecs_role" {
  name = "test-agents-${var.environment}-ecs"
  assume_role_policy = "${file("${path.module}/policies/ecs-instance-role.json")}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "test-agent-${var.environment}-ecs-instance-profile"
  path = "/"
  roles = ["${aws_iam_role.ecs_role.name}"]
}

resource "aws_iam_role_policy" "ecs_role_policy" {
  name = "test-agent-${var.environment}-ecs"
  role = "${aws_iam_role.ecs_role.id}"
  policy = "${file("${path.module}/policies/ecs-instance-role-policy.json")}"
}

resource "aws_instance" "agent" {
  ami = "ami-b6760fc5" // amzn-ami-2016.03.i-amazon-ecs-optimized
  instance_type = "t2.micro"
  key_name = "webapptest"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  associate_public_ip_address = true
  tags {
    Name = "WebAppTest Agent ECS Container Instance"
  }
  user_data = <<EOT
#!/bin/bash
echo ECS_CLUSTER=test-agents-${var.environment} > /etc/ecs/ecs.config
EOT
}

resource "aws_ecs_task_definition" "default" {
  family = "test-agent-${var.environment}"
  container_definitions = "${file("${path.module}/task-definition.json")}"
}
