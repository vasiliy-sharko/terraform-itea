variable "region" {
  type = string
  default = "us-east-1"
}

variable "ports_to_open" {
  type = list(string)
  default = ["22", "80"]
}

variable "ami_ids" {
  type = map(string)
  default = {
    us-east-1 = "ami-0947d2ba12ee1ff75"
    us-east-2 = "ami-03657b56516ab7912"
    eu-west-1 = "ami-0bb3fad3c0286ebd5"
  }
}

variable "instance_name" {
  type = string
  description = "Name of EC2 instance"
}