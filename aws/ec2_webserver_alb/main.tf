resource "aws_instance" "web_server_basic" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.key_web_server.key_name
  security_groups = [aws_security_group.sg.name]
  user_data = data.template_file.user_data.rendered
  tags = {
    Name = "ssh web_server"
  }

}

data "template_file" "user_data" {
  template = file("cloud-init.yaml")
}

resource "aws_security_group" "sg" {
  name = "allow_web_server (security group name)"
  description = "Allow web_server (description)"

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
    description = "Allow incoming http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "type" = "web_server security group"
  }
}

resource "aws_key_pair" "key_web_server" {
  key_name       = "web_server_key"
  public_key = file("id_rsa.pub")
}

resource "aws_lb" "my-test-lb" {
  name               = "my-test-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = [for s in data.aws_subnet.example : s.id]
  security_groups    = [aws_security_group.sg.id]
  enable_deletion_protection = true
  tags = {
    Name = "my-test-alb"
  }
}

resource "aws_lb_target_group" "my-alb-tg" {
  health_check {
    path                = "/"
    protocol            = "HTTP"
  }
  name        = "my-alb-tg"
  vpc_id      = aws_security_group.sg.vpc_id
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "my-tg-attachment1" {
  target_group_arn = aws_lb_target_group.my-alb-tg.arn
  target_id        = aws_instance.web_server_basic.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my-test-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-alb-tg.arn
  }
}

data "aws_subnet_ids" "example" {
  vpc_id = aws_security_group.sg.vpc_id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}

