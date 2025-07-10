#!/bin/bash

# -----------------------------
# Script to Install Docker & Jenkins
# -----------------------------
# This script will:
# 1. Install Docker
# 2. Start and enable Docker service
# 3. Add current user to docker group
# 4. Exit and ask user to reconnect
# 5. (Upon rerun) Pull Jenkins image and start container
# -----------------------------

# Exit if any command fails
set -e

# File marker to check if docker group step was completed
MARKER_FILE="/tmp/.docker_group_done"

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

# Check if docker group step has been done already
if [ ! -f "$MARKER_FILE" ]; then
  echo "========== Adding user 'ubuntu' to docker group =========="
  sudo usermod -aG docker ubuntu
  touch "$MARKER_FILE"
  echo ""
  echo "======================================================"
  echo "✅ User 'ubuntu' added to docker group."
  echo "🔁 Please logout and SSH back into the EC2 instance, then re-run this script."
  echo "🛑 Exiting now to apply group changes..."
  echo "======================================================"
  exit 0
fi

echo "========== Pulling official Jenkins image =========="
docker pull jenkins/jenkins:lts

echo "========== Creating Jenkins container =========="
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

echo "========== ✅ Jenkins is running on port 8080 =========="
echo "Open your browser and visit: http://<EC2-PUBLIC-IP>:8080"
echo "You can find the Jenkins initial admin password using:"
echo "docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword"
echo "======================================================"