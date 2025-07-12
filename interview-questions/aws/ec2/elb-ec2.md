### AWS EC2, ASG, ALB, NLB, and Launch Template Interview Questions with Detailed Answers

---

**1. Explain the different types of EC2 instances and their use cases.**
Amazon EC2 offers a wide variety of instance types, each designed for different workloads:

* **General Purpose (e.g., t3, m5)**: Balanced compute, memory, and networking resources. Ideal for web servers, development environments, and small databases.
* **Compute Optimized (e.g., c6g, c5)**: High-performance processors. Suitable for batch processing, video encoding, high-performance web servers.
* **Memory Optimized (e.g., r6g, x2idn)**: Designed for fast performance on memory-intensive applications like in-memory databases, real-time big data analytics.
* **Storage Optimized (e.g., i4i, d3en)**: High, sequential read and write access to large datasets. Used for NoSQL databases, file systems, data warehousing.
* **Accelerated Computing (e.g., p4, inf1)**: Equipped with GPUs or FPGAs. Best suited for machine learning, gaming, and high-performance computing.

---

**2. What is the difference between a Launch Template and a Launch Configuration?**
Both are used to define instance configuration for Auto Scaling Groups, but:

* **Launch Template (recommended)**:

  * Supports versioning.
  * Can be used across multiple ASGs.
  * Compatible with newer EC2 features like T2/T3 Unlimited, Placement Groups, and Mixed Instance Policies.

* **Launch Configuration**:

  * Cannot be modified; you must create a new one to change configuration.
  * Does not support new features introduced after 2017.

Launch Templates are more flexible and are the modern replacement for Launch Configurations.

---

**3. How does Auto Scaling Group (ASG) work with ALB/NLB?**

* An **ASG** manages a fleet of EC2 instances and automatically adjusts the number of instances based on load.
* An **ALB (Application Load Balancer)** or **NLB (Network Load Balancer)** can be attached to the ASG by registering the instances in a target group.
* When ASG launches new instances, it automatically registers them with the load balancer.
* Similarly, when instances are terminated, they are deregistered from the target group.

This integration ensures only healthy, in-service instances are receiving traffic.

---

**4. What are the key differences between ALB and NLB?**

| Feature          | ALB                          | NLB                               |
| ---------------- | ---------------------------- | --------------------------------- |
| Layer            | Layer 7 (Application)        | Layer 4 (Transport)               |
| Protocol Support | HTTP, HTTPS                  | TCP, UDP, TLS                     |
| Advanced Routing | Path- and host-based routing | No advanced routing               |
| Latency          | Slightly higher              | Ultra-low                         |
| Use Case         | Web applications             | Real-time apps, gaming, databases |
| Target Types     | Instance, IP, Lambda         | Instance, IP                      |

---

**5. Can an NLB forward traffic to AWS Lambda? Explain.**
No, **NLB does not support invoking AWS Lambda functions directly**. Only **ALB** supports Lambda as a target. If your architecture requires Layer 7 routing and Lambda execution, ALB is the correct choice.

---

**6. How does EC2 pricing work for Reserved, Spot, and On-Demand instances?**

* **On-Demand**: Pay-per-use model. Suitable for short-term or unpredictable workloads.
* **Reserved**: Commit to 1 or 3 years in exchange for a discount (up to 72%). Ideal for steady-state workloads.
* **Spot**: Bid for unused EC2 capacity with savings up to 90%. Suitable for fault-tolerant, stateless, or flexible tasks like data processing, CI/CD.

---

**7. How would you design a fault-tolerant EC2 architecture?**

* Deploy instances across **multiple Availability Zones (AZs)**.
* Use an **Auto Scaling Group (ASG)** for dynamic instance management.
* Place instances behind an **ALB/NLB** for load balancing.
* Store persistent data on **EBS volumes**, **S3**, or **RDS** with cross-AZ replication.
* Use **CloudWatch alarms** to trigger recovery actions.
* Implement **health checks** to replace unhealthy instances automatically.

---

**8. What are EC2 placement groups and their types?**
Placement Groups control how instances are placed on the underlying hardware:

* **Cluster Placement Group**: Groups instances within a single AZ and rack for low-latency, high-throughput. Best for HPC, ML.
* **Spread Placement Group**: Spreads instances across different racks and AZs. Minimizes simultaneous failures. Ideal for critical workloads.
* **Partition Placement Group**: Divides group into partitions, each in isolated hardware. Good for big data (e.g., Hadoop, Kafka).

---

**9. How to attach a lifecycle hook to an ASG?**
Lifecycle hooks allow custom actions when instances are launched or terminated.

Steps:

1. Define the hook:

```hcl
resource "aws_autoscaling_lifecycle_hook" "example" {
  name                   = "my-hook"
  autoscaling_group_name = aws_autoscaling_group.example.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 300
  default_result         = "CONTINUE"
}
```

2. Hook can send a notification to **SNS** or **SQS** for further automation.
3. Use Lambda or scripts to perform actions (e.g., backup, logging), then complete the lifecycle action using the AWS CLI or SDK.

---

**10. How does cross-zone load balancing affect ALB/NLB?**

* **Cross-zone load balancing** allows the load balancer to distribute traffic across all registered targets in all enabled Availability Zones.
* **ALB**: Enabled by default and free of charge.
* **NLB**: Disabled by default, can be enabled. Additional cost may apply.

Benefits:

* Ensures even distribution regardless of target AZ.
* Improves fault tolerance and availability.

Disabling it means traffic will only be routed to targets in the same AZ as the client, potentially causing uneven load.

---
