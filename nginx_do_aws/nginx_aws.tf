resource "aws_instance" "nginx_basic_web" {
  ami           = "ami-098f16afa9edf40be"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.daniel.key_name
  security_groups = [aws_security_group.sg.name]

 connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }


  tags = {
    Name = "Basic nginx"
  }

}

