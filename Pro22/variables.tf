variable "main_vpc_cidr" {
    type    = string
    default = "10.0.0.0/24"
}
variable "public_subnets" {
    type    = string
    default = "10.0.0.128/26"
}
variable "private_subnets" {
    type    = string
    default = "10.0.0.192/26"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ami" {
  type    = string
  default = "ami-069aabeee6f53e7bf"
}
