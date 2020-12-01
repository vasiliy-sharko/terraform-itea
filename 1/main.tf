provider "aws" {
  profile = "itea"
  region  = "us-east-1"
}

resource "aws_instance" "main" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
}
