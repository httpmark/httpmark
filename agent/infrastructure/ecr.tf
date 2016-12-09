resource "aws_ecr_repository" "default" {
  name = "httpmark-test-agent"
}

resource "aws_ecr_repository_policy" "default" {
  repository = "${aws_ecr_repository.default.name}"
  policy = "${file("${path.module}/policies/ecr.json")}"
}
