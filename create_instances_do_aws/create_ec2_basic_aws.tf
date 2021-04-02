resource "aws_instance" "example" {
  ami           = "ami-098f16afa9edf40be"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.daniel.key_name
}
