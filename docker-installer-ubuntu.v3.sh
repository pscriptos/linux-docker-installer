#!/bin/bash
# Script Name:  docker-installer.v3.sh
# Beschreibung: Docker & Docker-Compose Installer für Ubuntu 22.04 und Ubuntu 24.04
# Autor:        Patrick Asmus
# Web:          https://www.cleveradmin.de
# Git-Reposit.: https://git.techniverse.net/scriptos/linux-docker-installer
# Version:      3.5
# Datum:        13.06.2025
# Modifikation: compose version changed, zsh plugin handling optimized, opt-in for enable zsh plugin, cleanup
#####################################################

# Konfiguration
USER="root"
COMPOSEVERSION="v2.37.1"
DOCKER_ROOT_DIR="/var/lib/docker"
COMPOSE_DIR="/home/docker-projekte"
ENABLE_ZSH_PLUGIN=false

# Betriebssystem und Version prüfen
OS=$(lsb_release -is)
VERSION=$(lsb_release -rs)

if [ "$OS" != "Ubuntu" ] || { [ "$VERSION" != "22.04" ] && [ "$VERSION" != "24.04" ]; }; then
    echo "Dieses Script unterstützt nur Ubuntu 22.04 und Ubuntu 24.04. Installation abgebrochen."
    exit 1
fi

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

# Docker Compose installieren
sudo curl -L "https://github.com/docker/compose/releases/download/$COMPOSEVERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Optional: OhMyZSH Plugin für Docker aktivieren
if [ "$ENABLE_ZSH_PLUGIN" = true ]; then
    ZSHRC="/root/.zshrc"
    echo "OhMyZSH Plugin für Docker prüfen..."

    if grep -q "^plugins=" "$ZSHRC"; then
        if grep -q "docker" "$ZSHRC"; then
            echo "Docker ist bereits als Plugin eingetragen – keine Änderung nötig."
        else
            echo "Docker wird als Plugin hinzugefügt..."
            sudo sed -i '/^plugins=/ s/)/ docker)/' "$ZSHRC"
        fi
    else
        echo "WARNUNG: Keine Plugin-Zeile gefunden in $ZSHRC."
    fi
else
    echo "OhMyZSH Plugin-Konfiguration übersprungen (deaktiviert)."
fi

# Überprüfen der Installation
docker --version
docker-compose --version

exit 0