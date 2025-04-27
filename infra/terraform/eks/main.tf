provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["event-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  tags = {
    Tier = "private"  # Adjust based on your subnet tagging
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "event-web-app"
  cluster_version = "1.27"

  vpc_id     = data.aws_vpc.existing.id
  subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_groups = {
    default = {
      instance_types = ["t2.medium"]
      min_size      = 1
      max_size      = 3
      desired_size  = 2
    }
  }
}
