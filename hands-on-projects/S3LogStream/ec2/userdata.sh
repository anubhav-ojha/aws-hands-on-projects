#!/bin/bash
yum update -y
yum install -y python3 git
pip3 install boto3

# Copy the log processor script (will be created below)
mkdir -p /opt/s3logstream/
cd /opt/s3logstream/
curl -o log_processor.py https://raw.githubusercontent.com/anubhav-ojha/aws-hands-on-projects/hands-on-projects/S3LogStreamte/ec2/log_processor.py

# Run at startup
echo "*/5 * * * * root python3 /opt/s3logstream/log_processor.py" >> /etc/crontab
