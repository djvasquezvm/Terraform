resource "aws_instance" "demo_basic" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.key_demo.key_name
  security_groups = [aws_security_group.sg.name]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
	"sudo yum update -y",
	"sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64 vim",
	"cd /home/ec2-user/",
	"curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O",
	"unzip CloudWatchMonitoringScripts-1.2.2.zip",
	"rm -rf CloudWatchMonitoringScripts-1.2.2.zip",
	"/home/ec2-user/aws-scripts-mon/mon-put-instance-data.pl --mem-util --verify --verbose",
	"echo -e \"*/1 * * * * root /home/ec2-user/aws-scripts-mon/mon-put-instance-data.pl --mem-util --mem-used --mem-avail\" | sudo tee /etc/crontab",
	"sudo hostnamectl set-hostname demo_server"
    ]
  }
  tags = {
    Name = "ec2 demo"
  }

}

resource "aws_security_group" "sg" {
  name = "allow_demo (security group name)"
  description = "Allow demo (description)"

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
    "type" = "demo security group"
  }
}

resource "aws_key_pair" "key_demo" {
  key_name       = "demo_key"
  public_key = file("id_rsa.pub")
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "${aws_instance.demo_basic.id}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    }
  ]
}
EOF
}
