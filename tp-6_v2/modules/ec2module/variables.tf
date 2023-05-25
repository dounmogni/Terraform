variable instancetype {
  type        = string
  description = "set aws instance type"
  default     = "t2.micro"
}

variable sg_name {
  type        = string
  description = "set sg name "
  default     = "nicolas-sg"
}

variable aws_common_tag {
  type        = map
  description = "Set aws tag"
  default = {
    Name = "ec2-nicolas"
  }
}