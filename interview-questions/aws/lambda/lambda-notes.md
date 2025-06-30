# AWS Lambda Overview

## What is AWS Lambda?
AWS Lambda is a serverless compute service that lets you run code without provisioning or managing servers. It automatically handles infrastructure scaling, fault tolerance, and code execution.

### Key Characteristics
- **Virtual functions** – No server management required.
- **Short execution** – Suitable for short-lived processes.
- **On-demand execution** – Triggered by events or HTTP requests.
- **Automatic scaling** – Scales seamlessly with incoming workloads.

---

## Benefits
- 💰 **Simplified Pricing** – Pay only for the compute time consumed.
- 📊 **Monitoring** – Integrated with **AWS CloudWatch** for logs and metrics.
- 📈 **High Resource Limits** – Supports up to **10 GB RAM** per function.
- ⏰ **Serverless CRON Jobs** – Easily schedule recurring tasks.

---

## Lambda Invocation Models

### 1. Synchronous Invocation
Used when an immediate response is required from the function.

#### Characteristics:
- Follows a **Request–Response** model.
- Invoked via:
  - AWS **CLI**
  - AWS **SDKs**
  - **API Gateway**
  - **Application Load Balancer (ALB)**

#### ALB Integration:
- Exposes Lambda as a public **HTTP(S) endpoint**.
- Lambda function must be registered in a **Target Group** of the ALB.

#### Flow:

Client → HTTP(S) → ALB → Lambda (Target Group) → Response (SYNC)

> ALB transforms payloads between HTTP and JSON.

---

### 2. Asynchronous Invocation
Used for fire-and-forget scenarios, especially in event-driven architectures.

#### Common Triggers:
- **Amazon S3**
- **Amazon SNS**
- **Amazon CloudWatch Events**

#### Behavior:
- Events are added to an **event queue**.
- Lambda retries the function if errors occur:
  - **3 retries total**:
    - 1st retry: after 1 minute
    - 2nd retry: after 2 minutes

#### Failure Handling:
- Failed events after retries are forwarded to a **Dead Letter Queue (DLQ)**.
- DLQs can be **SQS** or **SNS** topics for further analysis.

