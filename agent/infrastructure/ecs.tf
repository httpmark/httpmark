resource "aws_ecs_cluster" "default" {
  name = "httpmark-test-agents-${var.environment}"
}

resource "aws_iam_role" "ecs_role" {
  name = "httpmark-test-agents-${var.environment}-ecs"
  assume_role_policy = "${file("${path.module}/policies/ecs-instance-role.json")}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "httpmark-test-agent-${var.environment}-ecs-instance-profile"
  path = "/"
  roles = ["${aws_iam_role.ecs_role.name}"]
}

resource "aws_iam_role_policy" "ecs_role_policy" {
  name = "httpmark-test-agent-${var.environment}-ecs"
  role = "${aws_iam_role.ecs_role.id}"
  policy = "${file("${path.module}/policies/ecs-instance-role-policy.json")}"
}

resource "aws_instance" "agent" {
  ami = "ami-b6760fc5" // amzn-ami-2016.03.i-amazon-ecs-optimized
  instance_type = "t2.micro"
  key_name = "httpmark"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  associate_public_ip_address = true
  tags {
    Name = "httpmark Agent ECS Container Instance"
  }
  user_data = <<EOT
#!/bin/bash
echo ECS_CLUSTER=test-agents-${var.environment} > /etc/ecs/ecs.config
EOT
}

resource "template_file" "test_agent_task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    image = "${replace(aws_ecr_repository.default.repository_url, "https://", "")}:latest"
    //port = "${var.app_tcp_port}"
    //hostname = "${var.app_hostname}"
  }
}

resource "aws_ecs_task_definition" "default" {
  family = "httpmark-test-agent-${var.environment}"
  container_definitions = "${template_file.test_agent_task_definition.rendered}"
}
