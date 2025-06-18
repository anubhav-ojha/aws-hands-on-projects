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

