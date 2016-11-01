resource "aws_key_pair" "key_pair" {
  key_name = "webapptest"
  public_key = "${file("${var.public_key_path}")}"
}
