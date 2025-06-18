# 🔧 Day 2: Docker CLI and Basic Commands — Commands Only

| Term          | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| **Image**     | A blueprint or read-only template (like a `.zip` file with your app setup) |
| **Container** | A running instance of that image (like an app running from a `.zip` file)  |

---

### 🔹 Pull an Image from DockerHub

```bash
docker pull nginx
```

### 🔹 Run a Container

```bash
docker run -d --name webserver -p 8080:80 nginx
```

### 🔹 List Running and All Containers

```bash
docker ps        # Show running containers
docker ps -a     # Show all containers (running + stopped)
```

### 🔹 Stop and Start Containers

```bash
docker stop webserver
docker start webserver
```

### 🔹 View Container Logs

```bash
docker logs webserver
```

### 🔹 Access Container Shell

```bash
docker exec -it webserver bash   # or use `sh` if bash not available
```

To exit the container shell:

```bash
exit
```

### 🔹 Remove Container and Image

```bash
docker stop webserver
docker rm webserver
docker rmi nginx
```

---

## ✅ Optional Practice

### Run a Container from Alpine and Explore

```bash
docker run -it alpine sh
```

Explore files, then exit:

```bash
ls
exit
```

### Clean Up Unused Data

```bash
docker system prune
```

> 🛑 **Use with caution** — this removes all unused containers, networks, and images.