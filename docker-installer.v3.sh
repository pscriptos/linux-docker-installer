#!/bin/bash
# Script Name:  docker-installer.v3.sh
# Beschreibung: Docker & Docker-Compose installieren und Docker-Root-Verzeichnis ändern (Für Ubuntu)
# Aufruf:       bash ./docker-installer.v3.sh
# Autor:        Patrick Asmus
# Web:          https://www.media-techport.de
# Git-Reposit.: https://git.media-techport.de/scriptos/docker-installer
# Version:      3.1.2
# Datum:        24.02.2024
# Modifikation: user is now added to the docker group earlier
#####################################################

# Variablen
USER="root"
DOCKER_ROOT_DIR="/docker"
COMPOSE_DIR="/compose"

# Docker installieren
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# Docker-Root-Verzeichnis ändern
sudo systemctl stop docker
sudo mkdir -p $DOCKER_ROOT_DIR
echo "{\"data-root\": \"$DOCKER_ROOT_DIR\"}" | sudo tee /etc/docker/daemon.json
cp /var/lib/docker/* $DOCKER_ROOT_DIR
rm -R /var/lib/docker
sudo systemctl start docker

# Erstelle Compose-Verzeichnis
mkdir $COMPOSE_DIR

# Docker-compose installieren
sudo apt install -y curl
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Optional: Plugin für Oh my ZSH aktivieren
echo "OhMyZSH Plugin für Docker hinzufügen"
sudo sed -i 's/plugins=(git)/plugins=(git docker)/g' /root/.zshrc

# Überprüfen der Installation
docker --version
docker-compose --version

exit 0
