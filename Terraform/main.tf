resource "aws_instance" "terrajenkinsec2" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data = <<EOF
    #!/bin/bash
    yum update –y
    wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade
    amazon-linux-extras install java-openjdk11 -y #install Java
    yum install jenkins -y #install Jenkins
    systemctl enable jenkins #Jenkins starts on boot
    systemctl start jenkins #starts Jenkins service now
    EOF
 
}

resource "aws_security_group" "JenkinsSG" {
  name        = "JenkinsSG"
  description = "Allow https and ssh and Jenkins"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
  
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_s3_bucket" "Jenkins_Artifact_Bucket" {
  bucket = "Jenkins_Artifact_Bucket"
  }