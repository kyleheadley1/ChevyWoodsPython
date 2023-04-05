resource "aws_security_group" "JenkinsSG" {
  name        = "JenkinsSG"
  description = "Allow HTTPS/ssh and Jenkins"
 

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

#vpc_security_group_ids = [aws_security_group.jenkins.id]

#resource "aws_network_interface_sg_attachment" "sg_attachment" {
#security_group_id    = "${data.aws_security_group.JenkinsSG.id}"
#}

resource "aws_instance" "terrajenkinsec2" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum upgrade -y
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOF

  vpc_security_group_ids = [aws_security_group.JenkinsSG.id]

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_s3_bucket" "jenkinsArtifactBucket" {
  bucket = var.s3bucketname
}

output "jenkins_url" {      #Prints instance public ip to console with :8080
  value = "http://${aws_instance.terrajenkinsec2.public_ip}:8080/"
}
