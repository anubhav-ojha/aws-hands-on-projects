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
