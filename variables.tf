variable "ami" {
  default = "ami-06a0b4e3b7eb7a300"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "availabilty_zone" {
  default = "ap-south-1b"
}

# Change this before applying the Changes to work
variable "domain" {
  default = "domain5"
}

# Creating a Random User in Cluster
variable "user" {
  default = "admin"
}