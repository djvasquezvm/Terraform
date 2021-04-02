resource "aws_instance" "ec2_basic_subnet1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name	= aws_key_pair.key_ec2.key_name
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg_subnet1.id]
  tags = {
    Name = var.tags_name_ec2_subnet1
  }
}

resource "aws_instance" "ec2_basic_subnet2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name	= aws_key_pair.key_ec2.key_name
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg_subnet2.id]
  tags = {
    Name = var.tags_name_ec2_subnet2
  }
}

resource "aws_key_pair" "key_ec2" {
  key_name       = var.key_name
  public_key = file("id_rsa.pub")
}

resource "aws_vpc" "danielvasquezvpc" {
  cidr_block                        = var.vpc_cidr_block
  instance_tenancy                  = var.instance_tenancy
  assign_generated_ipv6_cidr_block  = true
  tags = {
    Name = var.tags_name_vpc
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id		= aws_vpc.danielvasquezvpc.id
  cidr_block		= var.subnet1_cidr_block
  availability_zone	= var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = var.tags_name_subnet1
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id		= aws_vpc.danielvasquezvpc.id
  cidr_block		= var.subnet2_cidr_block
  availability_zone	= var.availability_zones[1]
  tags = {
    Name = var.tags_name_subnet2
  }
}

resource "aws_internet_gateway" "dv_vpc_gateway" {
  vpc_id = aws_vpc.danielvasquezvpc.id
  tags = {
    Name = var.tags_name_dv_vpc_gateway
  }
}
 
resource "aws_route_table" "routingtable_subnet1" {
  vpc_id = aws_vpc.danielvasquezvpc.id
  route {
    cidr_block = var.all_ipv4
    gateway_id = aws_internet_gateway.dv_vpc_gateway.id
  }
  route {
    ipv6_cidr_block = var.all_ipv6
    gateway_id = aws_internet_gateway.dv_vpc_gateway.id
  }
  tags = {
    Name = var.tags_name_route_table_subnet1
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.routingtable_subnet1.id
}

resource "aws_security_group" "sg_subnet1" {
  name = var.security_group_name_subnet1
  description = var.security_group_description_subnet1
  vpc_id = aws_vpc.danielvasquezvpc.id

  ingress {
    description = var.description_icmp
    from_port   = var.all_icmp
    to_port     = var.all_icmp
    protocol    = var.protocol_icmp
    cidr_blocks = [var.all_ipv4]
  }
  
  ingress {
    description = var.description_ssh
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = var.protocol_tcp
    cidr_blocks = [var.all_ipv4]
  }

  ingress {
    description = var.description_http
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = var.protocol_tcp
    cidr_blocks = [var.all_ipv4]
  }

  ingress {
    description = var.description_https
    from_port   = var.port_https
    to_port     = var.port_https
    protocol    = var.protocol_tcp
    cidr_blocks = [var.all_ipv4]
  }

  ingress {
    description = var.description_https
    from_port   = var.port_https
    to_port     = var.port_https
    protocol    = var.protocol_tcp
    ipv6_cidr_blocks  = [var.all_ipv6]
  }
  
  ingress {
    description = var.description_http
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = var.protocol_tcp
    ipv6_cidr_blocks  = [var.all_ipv6]
  }
 
  egress {
    from_port   = var.all_ports
    to_port     = var.all_ports
    protocol    = var.all_protocols
    cidr_blocks = [var.all_ipv4]
  }
  
  tags = {
    "type" = var.tags_name_sg_subnet1
  }
}

resource "aws_security_group" "sg_subnet2" {
  name = var.security_group_name_subnet2
  description = var.security_group_description_subnet2
  vpc_id = aws_vpc.danielvasquezvpc.id

  ingress {
    description = var.description_ssh
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = var.protocol_tcp
    cidr_blocks = [var.subnet1_cidr_block]
  }

  ingress {
    description = var.description_icmp
    from_port   = var.all_icmp
    to_port     = var.all_icmp
    protocol    = var.protocol_icmp
    cidr_blocks = [var.subnet1_cidr_block]
  }

  ingress {
    description = var.description_http
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = var.protocol_tcp
    cidr_blocks = [var.subnet1_cidr_block]
  }

  ingress {
    description = var.description_https
    from_port   = var.port_https
    to_port     = var.port_https
    protocol    = var.protocol_tcp
    cidr_blocks = [var.subnet1_cidr_block]
  }

  tags = {
    "type" = var.tags_name_sg_subnet2
  }
}
