#!/bin/bash
##########################################################################################
#               .--.
#              |o_o |
#              |:_/ |
#             //   \ \
#            (|     | )
#            /'\_   _/`\
#            \___)=(___/
#     _               _                      _              _          _  _
#  __| |  ___    ___ | | __ ___  _ __       (_) _ __   ___ | |_  __ _ | || |  ___  _ __
# / _` | / _ \  / __|| |/ // _ \| '__|_____ | || '_ \ / __|| __|/ _` || || | / _ \| '__|
#| (_| || (_) || (__ |   <|  __/| |  |_____|| || | | |\__ \| |_| (_| || || ||  __/| |
# \__,_| \___/  \___||_|\_\\___||_|         |_||_| |_||___/ \__|\__,_||_||_| \___||_|
#
#    (c) Patrick Asmus
#        support@media-techport.de
#        https://www.media-techport.de
##########################################################################################
# Last Update: 14. Oktober 2022
# Version 2.0.1
##########################################################################################
clear
sleep 2
exec > >(tee -i "/var/log/docker-installer2.log")
exec 2>&1
HOSTNAME="$(hostname)"
#Globale Funktion zur Aktualisierung und Bereinigung der Umgebung
function update_and_clean {
apt update
apt full-upgrade -y
apt autoclean -y
apt autoremove -y
}
#START
sleep 2
update_and_clean
apt install sudo -y
sudo apt-get install \
ca-certificates \
curl \
gnupg \
lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
update_and_clean
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
mkdir /docker
sudo service docker start
sudo service docker enable
sudo docker run hello-world
echo Fertig. Zeit fuer ein Bierchen.
exit 0