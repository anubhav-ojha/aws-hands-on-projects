### Terraform Interview Questions with Detailed Answers

---

**1. What is a Terraform module, and how do you use it?**
A Terraform module is a container for multiple resources that are used together. It promotes reusability, maintainability, and abstraction. Modules can be local (within the same repository) or remote (from Terraform Registry or GitHub). To use a module, you declare it using the `module` block and provide necessary input variables:

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my-vpc"
  cidr   = "10.0.0.0/16"
  azs    = ["us-east-1a", "us-east-1b"]
}
```

---

**2. How do you handle dependencies between Terraform modules?**
Terraform uses implicit and explicit dependencies:

* **Implicit**: Based on resource references using interpolation syntax (`resource_type.name.attribute`).
* **Explicit**: Using the `depends_on` meta-argument.
  To manage inter-module dependencies, pass output values from one module as input variables to another:

```hcl
module "network" {
  source = "./network"
}

module "compute" {
  source       = "./compute"
  subnet_id    = module.network.subnet_id
  depends_on   = [module.network]
}
```

---

**3. Explain the use of `count`, `for_each`, and `depends_on` in Terraform.**

* **count**: Creates multiple instances of a resource based on an integer value.

```hcl
resource "aws_instance" "web" {
  count = 3
  ami           = "ami-123"
  instance_type = "t2.micro"
}
```

* **for\_each**: Creates resources for each item in a map or set.

```hcl
resource "aws_instance" "web" {
  for_each = toset(["a", "b", "c"])
  ami           = "ami-123"
  instance_type = "t2.micro"
}
```

* **depends\_on**: Specifies resource dependencies explicitly to control provisioning order.

```hcl
resource "aws_instance" "example" {
  depends_on = [aws_vpc.main]
}
```

---

**4. What is the difference between `terraform taint` and `terraform destroy`?**

* `terraform taint`: Marks a specific resource for recreation on the next `terraform apply`.
* `terraform destroy`: Destroys all resources in the current state.

Example:

```bash
terraform taint aws_instance.web
terraform apply  # This will recreate the tainted instance
```

---

**5. How do you version and lock providers in Terraform?**
Use the `required_providers` block inside the `terraform` block to specify version constraints:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

This ensures consistent behavior across environments and prevents accidental upgrades.

---

**6. How does `terraform plan` differ from `terraform apply`?**

* `terraform plan`: Creates an execution plan, showing what actions Terraform will take.
* `terraform apply`: Applies the changes required to reach the desired state.

`terraform plan` is useful for previewing changes and is often integrated into CI/CD pipelines.

---

**7. How do you structure Terraform code for large-scale infrastructure?**
Best practices include:

* Organizing resources into modules (network, compute, security).
* Using separate workspaces for environments (dev, staging, prod).
* Keeping variables, outputs, and backends in dedicated files.
* Using a standard directory layout:

```
project/
  ├── modules/
  ├── envs/
  │   ├── dev/
  │   └── prod/
  └── main.tf
```

---

**8. What is the purpose of remote backends in Terraform?**
Remote backends (e.g., S3, Azure Blob, etc.) store the Terraform state file remotely, enabling:

* State sharing between teams
* State locking (e.g., with DynamoDB)
* Centralized state management

Example:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
```

---

**9. How do you manage secrets securely in Terraform?**

* Use tools like AWS Secrets Manager or HashiCorp Vault.
* Never hardcode secrets in `.tf` files.
* Use environment variables or encrypted variable files.

Example:

```bash
export TF_VAR_db_password="securepassword"
```

In the code:

```hcl
variable "db_password" {}
```

---

**10. Explain the lifecycle meta-argument in Terraform.**
The `lifecycle` block controls resource behavior:

* `create_before_destroy`: Ensures new resource is created before old one is destroyed.
* `prevent_destroy`: Prevents accidental deletion.
* `ignore_changes`: Ignores changes to specified attributes.

Example:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-123"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = ["tags"]
  }
}
```
