provider "aws" {
  region     = "us-east-1"
  #access_key = var.AWS_ACCESS_KEY
  #secret_key = var.AWS_SECRET_KEY
  #shared_credentials_file = "~/.aws/credentials" #lecture de vos credentials en local.(aws cli/aws configure)
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-nicolas"
    key    = "nicolas-prod.tfstate"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    #access_key = var.AWS_ACCESS_KEY
    #secret_key = var.AWS_SECRET_KEY
  }
}

module "ec2" {
  source = "../modules/ec2module"
  instancetype = "t2.micro"
 # instancetype = var.instancetype
  aws_common_tag = {
    Name = "ec2-dev-Nicolas"
  }
 
  
  sg_name = "prod-Nicolas-sg"
}