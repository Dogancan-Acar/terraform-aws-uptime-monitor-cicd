output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.uptime-server.public_ip
}

output "api_url" {
  description = "The URL to access the API documentation"
  value       = "http://${aws_instance.uptime-server.public_ip}:8080/docs"
}