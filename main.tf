resource "aws_instance" "uptime-server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name  
  vpc_security_group_ids = [aws_security_group.api_sg]
  
  tags = {
    Name = "Uptime-server"
  }


user_data = <<-EOF
            #!/bin/bash
            sudo apt -get update -y
            sudo apt -get install docker.io -y
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo docker run -d -p 8080:80 ${var.docker_image}
            EOF 

}
