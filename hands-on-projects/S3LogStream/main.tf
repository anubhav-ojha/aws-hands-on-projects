provider "aws" {
  region = "eu-west-1" # Change as needed
}

# Create S3 Bucket for Access Logs
resource "aws_s3_bucket" "access_logs" {
  bucket = "s3logstream-access-logs-2097868"
  force_destroy = true
}

# Create S3 Bucket for Static Website Hosting
resource "aws_s3_bucket" "website" {
  bucket = "s3logstream-website-2097868"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = aws_s3_bucket.access_logs.bucket
    target_prefix = "logs/"
  }
}

# Generate Unique Suffix for Bucket Names
resource "random_id" "suffix" {
  byte_length = 4
}

# Make Website Bucket Public (only for static files)
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-s3-log-parser"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # (Restrict in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "log_parser" {
  ami                    = "ami-01f23391a59163da9" # Amazon Linux 2 (us-east-1)
  instance_type          = "t2.micro"     # Replace or make variable
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  key_name               = "s3logstream-keypair"   # Add if you want SSH

  user_data              = file("ec2/userdata.sh")

  tags = {
    Name = "S3LogParserInstance"
  }
}
