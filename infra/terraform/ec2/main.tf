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
  description = "Allow SSH, HTTP, SonarQube, and monitoring access"
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

  # Prometheus, Node Exporter, Grafana
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube
  ingress {
    from_port   = 9000
    to_port     = 9000
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

# Launch EC2 instance for web app
resource "aws_instance" "event_instance" {
  ami                    = "ami-0e35ddab05955cf57" # Ubuntu 22.04 LTS in ap-south-1
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.event_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.eventgroups.id]

  user_data = file("install.sh")

  tags = {
    Name = "event-web-ec2"
  }
}

# Launch EC2 instance for monitoring tools
resource "aws_instance" "monitoring_instance" {
  ami                    = "ami-0e35ddab05955cf57" # Ubuntu 22.04 LTS in ap-south-1
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.event_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.eventgroups.id]

  user_data = file("monitoring_install.sh")

  tags = {
    Name = "monitoring-ec2"
  }
}
