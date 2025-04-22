provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "eventgroups" {
  name        = "eventgroups"
  description = "Allow SSH, HTTP and custom app access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "eventgroups"
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "event_instance" {
  ami                    = "ami-0ded8326293d3201b" # Ubuntu 22.04 LTS for ap-south-1
  instance_type          = "t2.medium"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.eventgroups.id]

  user_data = file("install.sh")

  tags = {
    Name = "event-web-ec2"
  }
}

