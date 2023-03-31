variable "instancetype" {
  type        = string
  description = "set aws instance type"
  default     = "t2.nano"

}

variable "aws_common_tag" {
  type        = map
  description = "set aws tag"
  default = {
    Name = "ec2-DND"
  }

}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}