variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-0e5467d64d955c6d5"
}
variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = "api-sg"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "project-ci_cd"
}
variable "docker_image" {
  description = "Full name of the image to pull from Docker Hub"
  type        = string
  default     = "dogancan0/uptime-api:v1"
}