variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "eu-west-1" # Change to your preferred region
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID for your region"
  default     = "ami-01f23391a59163da9" # Replace with your region-specific AMI
}

variable "key_name" {
  description = "Key pair name"
  default     = "monitoring-key"
}

variable "public_key_path" {
  description = "Path to your public key file"
  default     = "/path/to/your/public_key.pub" # Replace with your public key path
}

variable "my_ip_cidr" {
  description = "Your public IP with CIDR to allow SSH"
  default     = "0.0.0.0/0"
}
