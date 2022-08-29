terraform {
  cloud {
    organization = "attonizee"

    workspaces {
      name = "terraform-tutorial-environment"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-00785f4835c6acf64"
  instance_type = "t2.micro"

  tags = {
    Name  = var.instance_name
    Owner = "Anatolii Veselyi"
  }
}