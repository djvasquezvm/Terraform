variable "ami_nat" {
  default     = "ami-00a9d4a05375b2763"
  type        = string
}

variable "ami_normal" {
  default     = "ami-0947d2ba12ee1ff75"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  type        = string
}

variable "tags_name_ec2_subnet1_nat" {
  default     = "ec2 vpc subnet1 nat"
  type        = string
}

variable "tags_name_ec2_subnet1" {
  default     = "ec2 vpc subnet1"
  type        = string
}

variable "tags_name_ec2_subnet2" {
  default     = "ec2 vpc subnet2"
  type        = string
}

variable "key_name" {
  default     = "vpc ec2 key"
  type        = string
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
}

variable "instance_tenancy" {
  default     = "default"
  type        = string
}

variable "tags_name_vpc" {
  default     = "danielvasquezvpc"
  type        = string
}

variable "subnet1_cidr_block" {
  default     = "10.0.1.0/24"
  type        = string
}

variable "tags_name_subnet1" {
  default     = "subnet 10.0.1"
  type        = string
}

variable "subnet2_cidr_block" {
  default     = "10.0.2.0/24"
  type        = string
}

variable "tags_name_subnet2" {
  default     = "subnet 10.0.2"
  type        = string
}

variable "availability_zones" {
  default     = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e","us-east-1f"]
  type        = list
  description = "List of availability zones"
}

variable "tags_name_dv_vpc_gateway" {
  default     = "dv_vpc_internetgateway"
  type        = string
}

variable "tags_name_route_table_subnet1" {
  default     = "MyInternetRouteOut_Subnet1"
  type        = string
}

variable "tags_name_route_table_subnet2" {
  default     = "MyInternetRouteOut_UsingNat"
  type        = string
}

variable "security_group_name_subnet1" {
  default     = "security group vpc subnet1"
  type        = string
}

variable "security_group_description_subnet1" {
  default     = "security group vpc subnet1"
  type        = string
}

variable "security_group_name_subnet2" {
  default     = "security group vpc subnet2"
  type        = string
}

variable "security_group_description_subnet2" {
  default     = "security group vpc subnet2"
  type        = string
}

variable "description_icmp" {
  default     = "Allow icmp"
  type        = string
}

variable "description_ssh" {
  default     = "Allow ssh"
  type        = string
}

variable "description_http" {
  default     = "Allow http"
  type        = string
}

variable "description_https" {
  default     = "Allow https"
  type        = string
}

variable "protocol_tcp" {
  default     = "tcp"
  type        = string
}

variable "protocol_icmp" {
  default     = "icmp"
  type        = string
}

variable "port_ssh" {
  default     = "22"
  type        = string
}

variable "port_http" {
  default     = "80"
  type        = string
}

variable "port_https" {
  default     = "443"
  type        = string
}

variable "all_icmp" {
  default     = "-1"
  type        = string
}

variable "all_ports" {
  default     = "0"
  type        = string
}

variable "all_ipv4" {
  default     = "0.0.0.0/0"
  type        = string
}

variable "all_ipv6" {
  default     = "::/0"
  type        = string
}

variable "all_protocols" {
  default     = "-1"
  type        = string
}

variable "tags_name_sg_subnet1" {
  default     = "vpc security group subnet1"
  type        = string
}

variable "tags_name_sg_subnet2" {
  default     = "vpc security group subnet2"
  type        = string
}
