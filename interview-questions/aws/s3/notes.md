# 📘 S3 Notes

## 📌 Amazon S3 Use Cases

- **Backup & Storage** – Secure file storage.
- **Disaster Recovery** – Quick data restore after failures.
- **Archive** – Low-cost long-term storage.
- **Hybrid Cloud** – Connect on-premises and cloud storage.
- **App Hosting** – Host app files in the cloud.
- **Media Hosting** – Store and stream media content.
- **Data Lakes & Analytics** – Store and analyze large datasets.
- **Software Delivery** – Distribute apps and updates.
- **Static Website** – Host HTML/CSS/JS websites.

---

## 📂 Amazon S3 – Buckets

Amazon S3 allows people to store **objects (files)** in **“buckets” (directories)**.

- Buckets must have a **globally unique name** (across all regions and accounts).
- Buckets are defined at the **region level**.
- Although S3 appears global, **buckets are created in specific regions**.

### 🔤 Bucket Naming Convention

- No **uppercase letters**
- No **underscores (_)**  
- Length: **3–63 characters**
- **Must not** be in the format of an IP address (e.g., `192.168.1.1`)
- **Must start** with a **lowercase letter** or **number**
- **Must NOT** start with the prefix `xn--`
- **Must NOT** end with the suffix `-s3alias`

---

## 📁 Amazon S3 – Objects

- **Objects = Files** stored in S3.
- Each object has a **Key** = full path in the bucket.

### 🔑 Examples:
- `s3://my-bucket/my_file.txt`
- `s3://my-bucket/folder1/folder2/my_file.txt`

> 🔹 Key = **Prefix** (like folder path) + **Object name**

- No real folders/directories in S3 — just **keys with slashes `/`**
- The UI **visually mimics** folders but they're not real directories.

---

## 📄 Amazon S3 – Objects (Detailed Notes)

### 📦 Object Content
- The object value is the actual **content/body** of the file (e.g., text, image, video, etc.)

### 📏 Object Size Limits
- Maximum object size: **5 TB (5000 GB)**
- For uploads **larger than 5 GB**, use **Multipart Upload**:
  - Splits the file into smaller parts.
  - Improves upload reliability and performance.
  - Allows resuming if an upload fails midway.

### 🧾 Metadata
- **Metadata** = key-value pairs attached to an object.
- Two types:
  - **System Metadata** – Used by S3 (e.g., `content-type`, `content-length`)
  - **User Metadata** – Custom-defined

### 🏷️ Tags
- Up to **10 tags** per object.
- Each tag is a **Unicode key-value** pair.
- Useful for:
  - Security policies (e.g., tag-based access control)
  - Lifecycle management (e.g., auto-deletion, archiving)

### 🔄 Version ID
- If **versioning is enabled** on the bucket:
  - Each object gets a **unique Version ID**
  - Allows:
    - Multiple versions of the same object
    - **Recovery**, **rollback**, and **change tracking**

---
# 🔐 Amazon S3 – Security & Management Notes

---

## 🔐 Access Control Types

### 1. **User-Based Access (via IAM)**
- Use IAM policies to control which API actions a user can perform on S3.

### 2. **Resource-Based Access**
- **Bucket Policies**:
  - Set rules directly on a bucket.
  - Support cross-account access.
- **Object ACLs**:
  - Control access at the object level.
  - Finer-grained control, but can be disabled.
- **Bucket ACLs**:
  - Control access at the bucket level.
  - Rarely used and can also be disabled.

---

## ✅ Access Evaluation Logic

An IAM principal can access an object **if:**
- IAM policy **allows** OR resource policy **allows**,  
**AND**
- There is **no explicit deny**.

---

## 🔒 Encryption

- S3 supports **encryption of objects** using encryption keys.
- Protects **data at rest**.

---

## 📜 S3 Bucket Policies (Quick Notes)

- Written in **JSON** format.
- Apply to **buckets and objects**.

### Define:
- **Effect**: `Allow` or `Deny`
- **Actions**: Which S3 APIs are allowed/denied
- **Principal**: Who the policy applies to (user/account)

### ✅ Common Uses:
- Allow **public access** to a bucket
- Enforce **encryption** on uploads
- Grant **cross-account access**

---

## 📂 S3 Bucket Policies (Detailed)

Use S3 bucket policies to:
- Grant **public access** to the bucket
- **Force encryption** on uploaded objects
- Grant **access to another AWS account** (cross-account)

### 🧾 Optional Conditions:
- Based on **Public IP** or **Elastic IP** (not Private IP)
- Based on **Source VPC** or **VPC Endpoint** (only works with VPC endpoints)
- Based on **CloudFront Origin Identity**
- **MFA authentication** required for access

---

## 🔁 Amazon S3 – Versioning

- Enables **file versioning** at the bucket level.
- Overwriting a file creates a **new version** (v1, v2, v3...).
- Recommended as a **best practice**.

### ✅ Benefits:
- Protects against **unintended deletes**
- Allows **restore or rollback** to previous versions

### 📝 Notes:
- Files uploaded **before enabling versioning** have version `"null"`
- **Suspending** versioning does **not delete** previous versions

---

## 🌐 Amazon S3 – Replication

- After enabling replication, **only new objects** are replicated.
- Use **S3 Batch Replication** to replicate existing objects or failed replications.

### 🔄 Deletion Behavior:
- Can **replicate delete markers** (optional)
- **Deletions with a version ID** are **not replicated** (prevents malicious deletes)

### ⚠️ No Chaining:
- If:
  - Bucket 1 → replicates to Bucket 2
  - Bucket 2 → replicates to Bucket 3  
  Then:
  - **Objects from Bucket 1 won't replicate to Bucket 3**

---

## ♻️ Amazon S3 – Lifecycle Rules

### 🔁 Transition Actions:
- Move objects to **Standard-IA** after 60 days
- Move objects to **Glacier** after 6 months

### ❌ Expiration Actions:
- Delete access log files after 365 days
- Delete **old versions** of files (if versioning is enabled)
- Delete **incomplete multipart uploads**

### 🎯 Rule Targets:
- Based on **Prefix** (e.g., `s3://mybucket/mp3/*`)
- Based on **Tags** (e.g., `Department: Finance`)

---
