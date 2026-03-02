terraform {
  backend "s3" {
    bucket = "dogancan-uptime-tfstate-bucket-0003" 
    key    = "prod/terraform.tfstate"              
    region = "eu-central-1"
  }
}
resource "aws_instance" "uptime-server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.key_name  
  vpc_security_group_ids = [aws_security_group.api_sg.id]
  
  tags = {
    Name = "Uptime-server"
    Enviroment = "Just try"
  }


user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update -y
            sudo apt-get install docker.io -y
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo docker run -d -p 8080:80 ${var.docker_image}
            EOF 

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "dogancan-uptime-tfstate-bucket-0003" 

  lifecycle {
    prevent_destroy = true # 
  }
}