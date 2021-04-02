resource "aws_instance" "ec2_basic" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.key_ec2.key_name
  security_groups = [aws_security_group.sg.name]
  user_data = data.template_file.user_data.rendered
  tags = {
    Name = "ssh ec2"
  }

}

data "template_file" "user_data" {
  template = file("cloud-init.yaml")
}

resource "aws_security_group" "sg" {
  name = "allow_ec2 (security group name)"
  description = "Allow ec2 (description)"

  ingress {
    description = "Allow incoming ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
 ingress {
    description = "Allow incoming grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "type" = "ec2 security group"
  }
}

resource "aws_key_pair" "key_ec2" {
  key_name       = "ec2_key"
  public_key = file("id_rsa.pub")
}
