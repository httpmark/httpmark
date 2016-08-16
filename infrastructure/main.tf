provider "aws" {
  region = "eu-west-1"
  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  access_key = "${var.AWS_ACCESS_KEY_ID}"
}

module "agent_spawn" {
  source="./agents/spawn"
}
