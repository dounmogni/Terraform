provider "aws" {
  region     = "us-east-1"
  #access_key = var.AWS_ACCESS_KEY
  #secret_key = var.AWS_SECRET_KEY
  shared_credentials_files = ["~/.aws/credentials"] #lecture de vos credentials en local.(aws cli/aws configure)
}

terraform { #creation s3 pour conserver le tfstate
  backend "s3" {
    bucket = "terraform-backend-nicolas"
    key    = "dubois.tfstate"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    #access_key = "PUT YOUR OWN"
    #secret_key = "PUT YOUR OWN"
  }
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instancetype
  key_name        = "devops-nicolas"
  tags            = var.aws_common_tag
  security_groups = ["${aws_security_group.allow_http_https.name}"]


  root_block_device {
    delete_on_termination = true
  }

}

resource "aws_security_group" "allow_http_https" {
  name        = "nicolas-sg"
  description = "allow_http_https inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${aws_eip.lb.public_ip} ; ID: ${aws_instance.myec2.id} ; AZ: ${aws_instance.myec2.availability_zone}; >> infos_ec2.txt"
  }
}