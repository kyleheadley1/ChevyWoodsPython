resource "aws_security_group" "JenkinsSG" {
  name        = "JenkinsSG"
  description = "Allow HTTPS/ssh and Jenkins"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

#resource "aws_internet_gateway" "igw" {
  #vpc_id = var.vpc_id
#}


resource "aws_instance" "terrajenkinsec2" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("jenkins.sh")

  vpc_security_group_ids = [aws_security_group.JenkinsSG.id]

  tags = {
    Name = "JenkinsL2"
  }
}
resource "aws_s3_bucket" "jenkinsArtifactBucket" {
  bucket = var.s3bucketname
}

output "jenkins_url" {      #Prints instance public ip to console with :8080
  value = "http://${aws_instance.terrajenkinsec2.public_ip}:8080/"
}
