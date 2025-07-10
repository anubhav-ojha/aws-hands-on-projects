variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region to launch the instance"
}

variable "instance_type" {
  default     = "t3.medium"
  description = "EC2 instance type"
}

variable "key_name" {
  description = "Name of existing AWS key pair"
}
