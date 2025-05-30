# 🚀 ALB to Lambda - CloudFormation Stack

## 📋 Overview
Deploys an internet-facing ALB that forwards HTTP requests to a Lambda function.

## 🔧 Parameters
- `VpcId`: VPC where ALB is deployed
- `Subnet1`, `Subnet2`: Public subnets for ALB

## 🔐 IAM Role
- `LambdaExecutionRole`: Basic logging permissions for Lambda

## 🧠 Lambda Function
- Name: `ALBToLambdaFunction`
- Runtime: Python 3.12
- Responds with JSON: `{"message": "Hello from Lambda via ALB!"}`

## 🌐 Application Load Balancer
- Scheme: `internet-facing`
- Subnets: `Subnet1`, `Subnet2`
- Security Group: Allows inbound HTTP (port 80)

## 🎯 Target Group
- Type: `lambda`
- Target: Lambda function ARN

## 🎧 Listener
- Protocol: HTTP
- Port: 80
- Forwards to Lambda target group

## ✅ Permissions
- ALB granted `lambda:InvokeFunction` on the Lambda

## 📤 Output
- `ALBURL`: DNS name of the ALB

## 💡 Notes
- Ensure subnets are public with a route to the internet
- Use HTTPS in production
- Lightweight serverless solution for HTTP APIs
