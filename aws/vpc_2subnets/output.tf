resource "local_file" "ip_ec2_subnet1" {
  content = aws_instance.ec2_basic_subnet1.public_ip
  filename = "ip_ec2_subnet1.txt"
}

resource "local_file" "ip_ec2_subnet2" {
  content = aws_instance.ec2_basic_subnet2.private_ip
  filename = "ip_ec2_subnet2.txt"
}
