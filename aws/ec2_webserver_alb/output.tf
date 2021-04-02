resource "local_file" "ip_web_server" {
  content = aws_instance.web_server_basic.public_ip
  filename = "ip_web_server.txt"
}

