provider "aws" {
  region = "ap-south-1"
}
# create vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Terraform VPC"
  }
}
# create subnet

resource "aws_subnet" "terraform_subnet"{
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    name = "Terraform Subnet"
  }
}

# create internet gateway

resource "aws_internet_gateway" "terraform_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "Terraform Internet Gateway"
  }
}

# create security group

resource "aws_security_group" "terraform_security_group" {
  vpc_id = aws_vpc.terraform_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Terraform Security Group"
  }
}
resource "aws_instance" "demo" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
  subnet_id = aws_subnet.terraform_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Instance_created_by_Azure_DevOps_pipeline"
  }
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-created-by-terraform-through-azure-devops-pipeline"
  tags = {
    Name = "My bucket"
  }
  
}