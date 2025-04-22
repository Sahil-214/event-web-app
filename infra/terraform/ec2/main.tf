provider "aws" {
  region = "ap-south-1"
}

# Create a new VPC
resource "aws_vpc" "event_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "event-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "event_subnet" {
  vpc_id                  = aws_vpc.event_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "event-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "event_igw" {
  vpc_id = aws_vpc.event_vpc.id

  tags = {
    Name = "event-igw"
  }
}

# Create a route table
resource "aws_route_table" "event_rt" {
  vpc_id = aws_vpc.event_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.event_igw.id
  }

  tags = {
    Name = "event-rt"
  }
}

# Associate the route table with subnet
resource "aws_route_table_association" "event_assoc" {
  subnet_id      = aws_subnet.event_subnet.id
  route_table_id = aws_route_table.event_rt.id
}

# Create a security group in the new VPC
resource "aws_security_group" "eventgroups" {
  name        = "eventgroups"
  description = "Allow SSH, HTTP and custom app access"
  vpc_id      = aws_vpc.event_vpc.id

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

# Launch EC2 in the new VPC
resource "aws_instance" "event_instance" {
  ami                    = "ami-0e35ddab05955cf57" # Ubuntu 22.04 LTS for ap-south-1
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.event_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.eventgroups.id]

  user_data = file("install.sh")

  tags = {
    Name = "event-web-ec2"
  }
}
