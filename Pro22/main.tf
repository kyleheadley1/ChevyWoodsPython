resource "aws_vpc" "Main" {            # Creating VPC here
  cidr_block       = var.main_vpc_cidr # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"
  
    tags = {
    Name = "Pro22VPC"
  }
}
#Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.Main.id              # vpc_id will be generated after we create VPC
  
    tags = {
    Name = "Pro22IGW"
  }
}
#Create 2 Public Subnets.
resource "aws_subnet" "publicsubnet1" { # Creating Public Subnets
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.public_subnets # CIDR block of public subnets
  
    tags = {
    Name = "Pro22PublicSub1"
  }
}

resource "aws_subnet" "publicsubnet2" { # Creating Public Subnets
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.public_subnets # CIDR block of public subnets
  
    tags = {
    Name = "Pro22PublicSub2"
  }
}


#Create 2 Private Subnets                   # Creating Private Subnets
resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.private_subnets # CIDR block of private subnets
  
    tags = {
    Name = "Pro22PrivateSub1"
  }
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.private_subnets # CIDR block of private subnets
  
    tags = {
    Name = "Pro22PrivateSub2"
  }
}
#Route table for Public Subnets
resource "aws_route_table" "PublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
    tags = {
    Name = "PublicRT"
  }
}
#Route table for Private Subnets
resource "aws_route_table" "PrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    #nat_gateway_id = aws_nat_gateway.NATgw.id
  }
    tags = {
    Name = "PrivateRT"
  }
}
#Route table Association with Public Subnets
resource "aws_route_table_association" "PublicRTassociation1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.PublicRT.id
}
#Route table Association with Private Subnets
resource "aws_route_table_association" "PrivateRTassociation1" {
  subnet_id      = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.PrivateRT.id
}
resource "aws_route_table_association" "PrivateRTassociation2" {
  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.PrivateRT.id
}
#resource "aws_eip" "nateIP" {
  #vpc = true
#}
#Creating the NAT Gateway using subnet_id and allocation_id
#resource "aws_nat_gateway" "NATgw" {
  #allocation_id = aws_eip.nateIP.id
  #subnet_id     = aws_subnet.publicsubnet1.id
  
  #tags = {
    #Name = "Pro22NatGW"
  #}
#}
#Create a security group for WebTier/Webservers
resource "aws_security_group" "WebTierSG" {
  name        = "WebTierSG"
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.Main.id

  ingress { #SSH traffic
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress { #HTTP traffic
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #HTTPS traffic
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Create Databse Security group
resource "aws_security_group" "DatabaseSG" {
  name   = "DatabaseSG"
  vpc_id = aws_vpc.Main.id

ingress { #MYSQL Traffic
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Create Instance for Apache Webserver
resource "aws_instance" "Pro22Webtier1" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("apache.sh")

  vpc_security_group_ids = [aws_security_group.WebTierSG.id]

  tags = {
    Name = "Pro22Webtier1"
  }
}
#Create second Instance for Apache Webserver
resource "aws_instance" "Pro22Webtier2" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("apache.sh")

  vpc_security_group_ids = [aws_security_group.WebTierSG.id]

  tags = {
    Name = "Pro22Webtier2"
  }
}
#Create RDS MYSQL database
resource "aws_db_instance" "Pro22RdsDB" {
  allocated_storage    = 10
  #db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "22DB"
  password             = "22DBpass"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name    = "${aws_subnet.privatesubnet1.id}"
  vpc_security_group_ids  = ["${aws_security_group.DatabaseSG.id}"]
  
  tags = {
    Name = "Pro22RdsDB"
  }
}