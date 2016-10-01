output "cluster_id" { value = "${aws_ecs_cluster.default.id}" }
output "task_definition_id" { value = "${aws_ecs_task_definition.default.arn}" }
output "ecr_repository_url" { value = "${aws_ecr_repository.default.repository_url}" }
