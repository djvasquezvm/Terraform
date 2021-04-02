resource "aws_instance" "proxy_basic" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.key_proxy.key_name
  security_groups = [aws_security_group.sg.name]
  root_block_device {
      volume_size = "8"
  }
 connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install vim -y",
      "sudo hostnamectl set-hostname proxy_server",
      "sudo yum install httpd -y"
    ]
  }

  tags = {
    Name = "ssh proxy"
    Prueba2 = "ssh proxy"
  }

}

resource "aws_security_group" "sg" {
  name = "allow_proxy (security group name)"
  description = "Allow proxy (description)"

  ingress {
    description = "Allow incoming ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming wordpress"
    from_port   = 9090
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming wordpress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Allow incoming wordpress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming wordpress"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming wordpress"
    from_port   = 9090
    to_port     = 9090
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
    "type" = "proxy security group"
  }
}

resource "aws_key_pair" "key_proxy" {
  key_name       = "proxy_key"
  public_key = file("id_rsa.pub")
}
