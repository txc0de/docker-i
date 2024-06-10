#!/bin/bash

# Update the package index
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository for Docker
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the package index again
sudo apt-get update

# Install the latest version of Docker CE (Community Edition)
sudo apt-get install docker-ce -y

# Verify that Docker CE is installed correctly by running the hello-world image
sudo docker run hello-world

# Download the latest version of Docker Compose
LATEST_COMPOSE=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/$LATEST_COMPOSE/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Verify that Docker Compose is installed correctly
docker-compose --version

# Add your user to the docker group to run Docker without sudo
sudo usermod -aG docker $USER

# Print installation success message
echo "Docker and Docker Compose have been successfully installed."

# Instruct the user to log out and back in to apply group changes
echo "Please log out and log back in to apply the Docker group changes."
