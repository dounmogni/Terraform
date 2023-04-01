variable "instancetype" {
  type        = string
  description = "set aws instance type"
  

}
variable sg_name {
  type        = string
  description = "set sg name"
  
}

variable "MYTAG" {
  type        = map(any)
  description = "set aws tag"
  

}
variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}