# 🟢 AWS EC2 Scenario-Based Questions – Beginner Level

This section contains practical scenario-based AWS EC2 questions with detailed answers for beginners, focused on networking, access, and troubleshooting.

---

### ❓ Question 1:  
**You have launched an EC2 instance but cannot SSH into it. What are the possible reasons and how would you troubleshoot this?**

### ✅ Answer:

There can be several reasons for not being able to SSH into an EC2 instance. Here's a step-by-step checklist to troubleshoot:

1. **Security Group Rules:**
   - Ensure the security group attached to the instance allows inbound traffic on port `22` (SSH).
   - Rule example:
     ```
     Type: SSH
     Protocol: TCP
     Port Range: 22
     Source: Your IP (e.g., 203.0.113.25/32)
     ```

2. **Public IP or Elastic IP:**
   - Confirm that the EC2 instance has a **public IP address** if it's in a public subnet.
   - Alternatively, associate an **Elastic IP** to make it persist even after reboots.

3. **Key Pair and SSH Command:**
   - Make sure you are using the correct **private key** (`.pem` file) and correct **user** in your SSH command:
     ```bash
     ssh -i "your-key.pem" ec2-user@<Public-IP>
     ```
   - Common default users:
     - Amazon Linux: `ec2-user`
     - Ubuntu: `ubuntu`
     - CentOS: `centos`

4. **Network ACLs (NACLs):**
   - Check that the subnet's NACL allows inbound/outbound traffic on port `22`.
   - NACL should allow:
     - Inbound: `Port 22` from your IP
     - Outbound: `Ephemeral ports` (1024–65535)

5. **Instance State and Reachability:**
   - Verify the instance is in `running` state.
   - Check **System Status Checks** and **Instance Status Checks** in the EC2 console.

6. **VPC/Subnet Configuration:**
   - Ensure the instance is in a **public subnet** (with a route to an Internet Gateway) if you're trying to connect from the internet.

7. **Correct Region:**
   - Make sure you are looking at the correct region where the instance is launched.

8. **Local Firewall:**
   - Ensure that your local machine’s firewall or antivirus is not blocking outbound port 22.

---

### ❓ Question 2:  
**You created a new EC2 instance in a public subnet but it cannot access the internet. What could be wrong?**

### ✅ Answer:

If an EC2 instance in a public subnet cannot access the internet, possible issues and resolutions include:

1. **Missing Internet Gateway:**
   - Ensure your VPC is attached to an **Internet Gateway (IGW)**.
   - Go to **VPC Console → Internet Gateways → Attach to VPC**.

2. **Route Table Configuration:**
   - Check the subnet’s route table and verify a route like:
     ```
     Destination: 0.0.0.0/0
     Target: igw-xxxxxxxx
     ```

3. **Public IP Address:**
   - The instance must have a **public IP** or **Elastic IP**.
   - If not assigned at launch, go to EC2 → Networking → Assign Public IP or associate an Elastic IP.

4. **Security Group and NACL Rules:**
   - Ensure outbound traffic on all ports is allowed in both security groups and NACLs.

5. **DNS Resolution:**
   - If using domain names (e.g., `yum update` or `apt-get`), ensure:
     - VPC has **DNS resolution** and **DNS hostnames** enabled.

6. **Check Source/Destination Check:**
   - Usually not needed unless instance is acting as a NAT, but worth verifying.

---

### ❓ Question 3:  
**You terminated an EC2 instance, but you still want to access the logs it generated. How would you do that?**

### ✅ Answer:

Once an EC2 instance is terminated, the **ephemeral storage (instance store)** is lost, but data on **EBS volumes** can be recovered **if they weren’t deleted on termination**.

Steps:

1. **Check EBS Volume Deletion Settings:**
   - If the EBS volume was not set to “Delete on termination”, it still exists.
   - Go to **EC2 → Volumes** and check for available volumes.

2. **Create a New Instance:**
   - Launch a new EC2 instance in the same Availability Zone.

3. **Attach Old EBS Volume:**
   - Attach the old volume to the new instance as a secondary volume (e.g., `/dev/sdf`).

4. **Mount and Access Logs:**
   - SSH into the new instance and mount the volume:
     ```bash
     sudo mkdir /mnt/oldvolume
     sudo mount /dev/xvdf1 /mnt/oldvolume
     ls /mnt/oldvolume
     ```
   - You can now access and copy logs.

5. **Use Amazon CloudWatch (Best Practice):**
   - For future use, configure **CloudWatch Logs Agent** or **CloudWatch Agent** to stream logs to CloudWatch for persistent storage even after termination.

---

📝 **Note:**  
These are beginner-level troubleshooting questions every AWS practitioner should master before moving to networking, scaling, and automation scenarios.

---

# 🟢 AWS EC2 Scenario-Based Questions – Intermediate Level

These questions address common architectural and operational challenges involving EC2 in AWS, with best practices for networking, security, and scalability.

---

### ❓ **1. You launched multiple EC2 instances in a private subnet. They need to access the internet to download updates. How would you set this up securely?**

### ✅ **Answer:**

To enable EC2 instances in a **private subnet** to securely access the **internet** (e.g., to download software updates), follow these steps:

#### 🔒 Use a NAT Gateway (Secure & Managed)
1. **Create a NAT Gateway** in a **public subnet**.
2. **Attach an Elastic IP** to the NAT Gateway for internet access.
3. **Update route table** of the **private subnet**:
   - Add a route: `0.0.0.0/0 → NAT Gateway ID`.
4. **Ensure Security Groups and NACLs** allow outbound HTTPS (port 443) traffic.

#### ✅ Why NAT Gateway?
- **Secure**: EC2 instances remain in the private subnet (not directly exposed).
- **Managed Service**: AWS handles high availability and scaling.
- **No inbound access** is allowed to private EC2 instances from the internet.

#### 🛑 Avoid:
- Avoid assigning public IPs to private subnet instances.
- Avoid using a NAT **instance** unless there's a strong cost constraint and management capability.

---

### ❓ **2. Your EC2 instance needs to read files from an S3 bucket. What are the secure and scalable ways to allow this access without storing AWS credentials on the instance?**

### ✅ **Answer:**

To securely grant S3 access to an EC2 instance **without hardcoding credentials**, use **IAM Roles** and **Instance Profiles**.

#### 🔐 Steps:
1. **Create an IAM Role**:
   - Attach a policy with least privilege (e.g., read-only access to the S3 bucket):
     ```json
     {
       "Effect": "Allow",
       "Action": ["s3:GetObject"],
       "Resource": ["arn:aws:s3:::your-bucket-name/*"]
     }
     ```
2. **Attach the IAM Role to the EC2 instance**:
   - Either during instance launch or later using the EC2 console/CLI.
3. **Access S3 from the instance** using AWS SDKs, CLI, or tools (e.g., `aws s3 cp`).

#### 📈 Benefits:
- **No credentials** are stored on the instance.
- **Auto-rotated temporary credentials** are provided via the EC2 metadata service (`http://169.254.169.254`).
- **Scalable**: Works for any number of instances with the role.

---

### ❓ **3. An EC2 instance hosting a web app is under heavy traffic. What steps can you take to handle the load without downtime?**

### ✅ **Answer:**

To handle heavy traffic and ensure **high availability and scalability**, follow these practices:

#### ⚙️ Step-by-step Strategy:

1. **Use an Elastic Load Balancer (ELB)**:
   - Distribute traffic across multiple EC2 instances.
   - Improves fault tolerance and availability.

2. **Auto Scaling Group (ASG)**:
   - Automatically add/remove EC2 instances based on CPU, memory, or request metrics.
   - Define minimum, desired, and maximum capacity.

3. **Use Amazon CloudFront (CDN)**:
   - Cache static content at edge locations.
   - Reduces load on EC2 and improves latency for global users.

4. **Enable Caching (App Level)**:
   - Use services like **Amazon ElastiCache** (Redis/Memcached).
   - Reduces repeated database or compute operations.

5. **Database Optimization**:
   - Use **Amazon RDS** with **read replicas** or **Aurora Auto Scaling**.
   - Offload read traffic from primary DB.

6. **Monitor with CloudWatch**:
   - Set alarms and auto scale triggers.
   - Diagnose and act on bottlenecks quickly.

#### ☁️ Optional Enhancements:
- Migrate to **containerized architecture** (ECS/Fargate or EKS).
- Use **Application Load Balancer (ALB)** for path-based routing.

---


