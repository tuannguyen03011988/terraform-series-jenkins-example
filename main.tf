terraform {
  backend "s3" {
    bucket         = "terraform-series-tuan-s3-backend"
    key            = "terraform-jenkins"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::462225643921:role/Terraform-Series-Tuan1S3BackendRole"
    dynamodb_table = "terraform-series-tuan-s3-backend"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
}

