resource "aws_key_pair" "daniel" {
  key_name       = "danielkey"
  public_key = file("id_rsa.pub")
}
