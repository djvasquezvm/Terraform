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

resource "aws_security_group" "rds" {
  name        = "terraform_rds_security_group"
  description = "Terraform example RDS MySQL server"
  ingress {
    description = "Allow incoming querys"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-example-rds-security-group"
  }
}

resource "aws_db_instance" "default" {
  identifier                = "terraform-mysql"
  allocated_storage         = 5
  engine                    = "mysql"
  engine_version            = "8.0.20"
  instance_class            = "db.t2.micro"
  name                      = "terraform_test_db"
  username                  = "terraform"
  password                  = "password"
  vpc_security_group_ids    = [aws_security_group.rds.id]
  skip_final_snapshot       = true
}
