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
# Last Update: 06. November 2021
# Version 1.0.2
##########################################################################################
clear
sleep 2
exec > >(tee -i "/var/log/docker-installer.log")
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
apt install docker-compose docker docker.io -y
mkdir /docker
touch /docker/docker-compose.yaml
echo OhMyZSH Plugin für Docker hinzufügen
sudo sed -i 's/plugins=(git)/plugins=(git docker)/g' /root/.zshrc
echo Fertig. Zeit fuer ein Bierchen.
cat /dev/null > ~/.bash_history && history -c && history -w
exit 0