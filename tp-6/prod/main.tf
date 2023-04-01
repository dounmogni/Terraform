provider "aws" {
  region     = "us-east-1"
  #access_key = "YOUR OWN ACCES KEY"
  #secret_key = "YOUR OWN SECRET KEY"
  shared_credentials_file = "~/.aws/credentials" #lecture de vos credentials en local.(aws cli/aws configure)
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-nicolas"
    key    = "nicolas-prod.tfstate"
    region = "us-east-1"
    #access_key = "YOUR OWN ACCES KEY"
    #secret_key = "YOUR OWN SECRET KEY"
    shared_credentials_file = "~/.aws/credentials"
  }
}

module "ec2" {
  source = "../modules/ec2module"
  instancetype = "t2.micro"
  aws_common_tag = {
    Name = "ec2-prod-nicolas"
  }
 
  
  sg_name = "prod-nicolas-sg"
}
