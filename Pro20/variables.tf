variable "ami" {
  type    = string
  default = "ami-069aabeee6f53e7bf"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_name" {
  type    = string
  default = "JenkinsL2"
}


variable "vpc_id" {
  type    = string
  default = "vpc-026f49c079f59f5df"
}



variable "security_group" {
  type    = string
  default = "t2.micro"
}

variable "cidr" {
  description = "CIDR"
  type        = string
  default     = "0.0.0.0/0"
}



