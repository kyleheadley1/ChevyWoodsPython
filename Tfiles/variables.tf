variable "ami" {
  type    = string
  default = "ami-00c39f71452c08778"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_name" {
  type    = string
  default = "Jenkins"
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



