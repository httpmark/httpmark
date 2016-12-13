provider "aws" {
  region = "eu-west-1"
  secret_key = "${var.aws_secret_key}"
  access_key = "${var.aws_access_key}"
}

module "test_agent" {
  source="../agent/infrastructure"
  aws_secret_key="${var.aws_secret_key}"
  aws_access_key="${var.aws_access_key}"
  public_key_path="${var.public_key_path}"
}
