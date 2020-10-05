terraform {
  backend "s3" {
    bucket  = "devops-course-lesson-7"
    key     = "part-2/terraform.tfstate"
    profile = "itea"
    region  = "us-east-1"
  }
}

provider "aws" {
  profile = "itea"
  region  = var.region
}

resource "aws_instance" "main" {
  ami                    = lookup(var.ami_ids, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "main" {
  description = "Managed by Terraform"
  vpc_id      = aws_default_vpc.default.id
}

resource "aws_security_group_rule" "out" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}

resource "aws_security_group_rule" "in" {
  for_each          = toset(var.ports_to_open)
  to_port           = each.value
  from_port         = each.value
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}