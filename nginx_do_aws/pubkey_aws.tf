resource "aws_key_pair" "daniel" {
  key_name       = "nginx_key"
  public_key = file("id_rsa.pub")
}
