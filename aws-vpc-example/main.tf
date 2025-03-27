provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = false

  tags = var.tags
}

# Example EC2 instance in the public subnet for testing
resource "aws_instance" "example" {
  count         = var.create_test_instance ? 1 : 0
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.example[0].id]

  tags = merge(
    var.tags,
    {
      Name = "example-instance"
    }
  )
}

resource "aws_security_group" "example" {
  count  = var.create_test_instance ? 1 : 0
  name   = "example-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
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

  tags = var.tags
}
