#!/bin/bash
# Script Name:  docker-installer.v3.sh
# Beschreibung: Docker & Docker-Compose Installer für Ubuntu 22.04 Jammy und Ubuntu 24.04
# Aufruf:       bash ./docker-installer.v3.sh
# Autor:        Patrick Asmus
# Web:          https://www.techniverse.net
# Git-Reposit.: https://git.techniverse.net/scriptos/linux-docker-installer
# Version:      3.4
# Datum:        12.06.2024
# Modifikation: Unterstützung für Ubuntu 24.04 hinzugefügt, OS-Prüfung aktualisiert
#####################################################

# Betriebssystem und Version prüfen
OS=$(lsb_release -is)
VERSION=$(lsb_release -rs)

if [ "$OS" != "Ubuntu" ] || { [ "$VERSION" != "22.04" ] && [ "$VERSION" != "24.04" ]; }; then
    echo "Dieses Script unterstützt nur Ubuntu 22.04 und Ubuntu 24.04. Installation abgebrochen."
    exit 1
fi

# Variablen
USER="root"
DOCKER_ROOT_DIR="/docker"
COMPOSE_DIR="/docker-compose"

# Docker installieren
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

if [ "$VERSION" == "22.04" ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
elif [ "$VERSION" == "24.04" ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

# Docker-Root-Verzeichnis ändern & Compose Verzeichnis erstellen
sudo systemctl stop docker
sudo mkdir -p $DOCKER_ROOT_DIR
echo "{\"data-root\": \"$DOCKER_ROOT_DIR\"}" | sudo tee /etc/docker/daemon.json > /dev/null
cp /var/lib/docker/* $DOCKER_ROOT_DIR -r
rm -R /var/lib/docker
sudo systemctl start docker

mkdir -p $COMPOSE_DIR

# Docker-compose installieren (gleicher Prozess für beide Versionen)
sudo apt install -y curl
sudo curl -L "https://github.com/docker/compose/releases/download/v2.12.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Optional: Plugin für Oh my ZSH aktivieren
echo "OhMyZSH Plugin für Docker hinzufügen"
sudo sed -i 's/plugins=(git)/plugins=(git docker)/g' /root/.zshrc

# Überprüfen der Installation
docker --version
docker-compose --version

exit 0
