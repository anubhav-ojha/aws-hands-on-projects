# 🐳 Day 1: Introduction to Docker (EC2 Edition)

## 🎯 Goal
- Understand what Docker is and how it works
- Run your **first container** using Docker

---

## 🧠 Concepts to Know

### 🔹 What is Docker?

Docker is a platform to **develop, ship, and run applications in containers**. Containers are lightweight, portable, and ensure the application works the same on all environments.

> Think of containers as mini-VMs, but much more efficient and faster.

---

### 🧱 Docker Components

- **Docker Engine** – The core service running in your EC2
- **Images** – Read-only blueprints (like a recipe)
- **Containers** – Running instances of an image
- **DockerHub** – Public image registry

---

## 💻 Hands-on Lab on EC2

Make sure Docker is installed and running on your EC2 instance.

---

### ✅ Step 1: Check Docker is Installed

```bash
docker --version
docker info
```

### ✅ Step 2: Run Your First Container

```bash
docker run hello-world
```

**What this does:**
- Docker checks for the image `hello-world` locally.
- If not found, it pulls it from DockerHub.
- Then it runs a container from that image.

**Expected Output:**
```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

---

### ✅ Step 3: List Running Containers

```bash
docker ps        # Shows only running containers
docker ps -a     # Shows ALL containers (running + stopped)
```

---

### ✅ Step 4: Remove the Container

```bash
docker container ls -a         # Get container ID or name
docker container rm <id/name>  # Remove it
```

---

### 🧹 Step 5: Clean Up Image (Optional)

```bash
docker image ls                # List all images
docker image rm hello-world    # Remove the hello-world image
```

---

## 🎓 Today’s Takeaways

Docker is installed and working ✅

You understand:
- Images 🧱
- Containers 📦
- Docker commands ⚙️

You ran and cleaned up your first container 🎉


---

## ✅ What is Docker?

Docker is a platform that lets you package and run applications in isolated environments called **containers**. It's lightweight, fast, and ideal for DevOps and cloud-native development.

---
## 🔹 Key Docker Concepts

### 🧠 Docker Client
- What you interact with (e.g. terminal/CLI).
- Sends commands (like `docker run`) to the Docker daemon.

### 🧠 Docker Daemon
- The background service (`dockerd`) that does the actual work (e.g. pulling images, creating containers).
- Listens to requests from the Docker client.

### 🧠 Docker Hub
- A public registry where Docker images are stored.
- Think of it like GitHub, but for container images.
- Official and community-maintained images are available here.

### 🧠 Docker Image
- A **read-only blueprint** of your application.
- Includes OS, application code, runtime, libraries, and dependencies.
- Used to create a running container.

---

## 🚀 What Happens When You Run `docker run hello-world`

1. Docker Client contacts Docker Daemon.
2. Docker Daemon pulls `hello-world` image from Docker Hub if not found locally.
3. A container is created from the image.
4. Container runs a program which outputs a message.
5. Output is streamed back to the terminal.

---

## 📦 What Happens When You Run `docker run -it ubuntu bash`

1. Docker pulls the `ubuntu` image if not already present.
2. A container is created from that image.
3. `bash` shell runs inside the container.
4. You get dropped into a shell like a Linux terminal.
5. You can run commands, install tools, and explore Ubuntu in isolation.

---

## 🤖 Docker vs Virtual Machine (VM)

| Feature            | Docker Container                   | Virtual Machine                |
|--------------------|-------------------------------------|---------------------------------|
| Boot Time          | Instant (milliseconds)              | Slower (seconds to minutes)     |
| OS Overhead        | Shares host kernel (lightweight)    | Full guest OS (heavy)           |
| Size               | MBs                                 | GBs                             |
| Performance        | Near-native                         | Some overhead                   |
| Isolation          | Process-level                       | Full OS-level                   |
| Use Case           | Microservices, Dev/Test environments | Full OS experience, legacy apps |

---

## 🆚 Ubuntu in Container vs Ubuntu OS

| Topic               | Ubuntu in Container                             | Ubuntu as OS (Host Machine)      |
|---------------------|--------------------------------------------------|----------------------------------|
| Kernel              | Uses host machine's kernel                       | Has its own kernel               |
| Systemd (init)      | Not available (no system services)               | Fully available                  |
| Persistence         | Files disappear unless volume is mounted        | Fully persistent                 |
| Resource Isolation  | Shares resources with host                       | Dedicated hardware usage         |
| Scope               | Only the app + shell (minimal)                   | Full desktop/server OS           |
| Boot Process        | No traditional booting, just starts a process    | Full boot process with init      |

**In simple words:**  
A Docker container with Ubuntu is like a _mini-Ubuntu running inside a box_ that shares your machine’s core but acts like its own small world.

---

## 🔧 Try This Inside a Container

```bash
docker run -it ubuntu bash

# Once inside:
ls /
cat /etc/os-release
apt update && apt install curl -y
echo "Hello" > /hello.txt
