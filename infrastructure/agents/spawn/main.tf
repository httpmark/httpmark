resource "aws_iam_role" "iam_webapptest_role_lambda" {
  name = "iam_webapptest_role_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_webapptest_role_policy_lambda" {
  name = "lambda_policy"
  role = "${aws_iam_role.iam_webapptest_role_lambda.id}"
  policy = <<EOF
{
  "Statement": [{
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ],
    "Effect": "Allow",
    "Resource": "arn:aws:logs:*:*:*"
  }]
}
EOF
}

resource "aws_lambda_function" "webapptest_agent_lambda" {
  filename = "./tmp/agent_spawn_deploy/agent_spawn.zip"
  source_code_hash = "${base64sha256(file("./tmp/agent_spawn_deploy/agent_spawn.zip"))}"
  function_name = "webapptest_agents"
  runtime = "nodejs4.3"
  role = "${aws_iam_role.iam_webapptest_role_lambda.arn}"
  handler = "index.handler"
}
