#!/bin/bash

# -----------------------------
# Script to Install Docker & Jenkins
# -----------------------------
# This script will:
# 1. Install Docker
# 2. Start and enable Docker service
# 3. Add current user to docker group
# 4. Pull Jenkins official Docker image
# 5. Run Jenkins in a Docker container
# -----------------------------

# Exit if any command fails
set -e

echo "========== Updating system =========="
sudo apt update -y
sudo apt upgrade -y

echo "========== Installing prerequisites =========="
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "========== Adding Docker GPG key =========="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "========== Setting up Docker repository =========="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "========== Installing Docker Engine =========="
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "========== Starting Docker service =========="
sudo systemctl start docker
sudo systemctl enable docker

echo "========== Adding user 'ubuntu' to docker group =========="
sudo usermod -aG docker ubuntu

echo "========== Pulling official Jenkins image =========="
docker pull jenkins/jenkins:lts

echo "========== Creating Jenkins container =========="
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

echo "========== Jenkins is running on port 8080 =========="
echo "Access it using: http://<EC2-PUBLIC-IP>:8080"
