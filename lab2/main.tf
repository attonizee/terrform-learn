provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "web" {
    ami = "ami-06b0bb707079eb96a" //Amazon Linux 2
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "aws_security_group.web.id" ]
    user_data = <<EOF
    #!/bin/bash
    yum -y update
    yum -y install httpd
    MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
    echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Built by TErraform" > /var/www/html/index.html
    service httpd start
    chkconfig httpd on
    EOF
    tags = {
        Name = "WebServer Built by Terraform"
        Owner = "Anatolii Veselyi"
    }
}

resource "aws_security_group" "web" {
    name = "WebServer-SG"
    description = "Security Group for my WebServer"

   ingress = [ {
     cidr_blocks = [ "0.0.0.0/0" ]
     description = "allow http"
     from_port = 80
     ipv6_cidr_blocks = [ "::/0" ]
     prefix_list_ids = [ "value" ]
     protocol = "tcp"
     security_groups = [ "value" ]
     self = false
     to_port = 1
   } ]

    tags = {
      "Name" = "WebServer SG Terraform"
      "Owner" = "Anatolii Veselyi"
    }

    
}