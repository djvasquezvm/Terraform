resource "local_file" "ip_ec2" {
  content = aws_instance.demo_basic.public_ip
  filename = "ip_ec2.txt"
}

