output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ssh_command" {
  value = "ssh -i /path/to/jenkins-KeyPair.pem ubuntu@${aws_instance.ec2_instance.public_ip}"
}
