# 🐳 Docker Installer Script für Ubuntu 22.04 & 24.04

Dieses Bash-Skript installiert Docker und Docker-Compose auf einem Ubuntu-System (22.04 oder 24.04), passt bei Bedarf das Docker-Root-Verzeichnis an und kann optional das OhMyZSH-Plugin für Docker aktivieren.

---

## ✅ Features

- Installation von:
  - Docker Engine (inkl. Repository-Einbindung)
  - Docker Compose (als Binärdatei, konfigurierbare Version)
- Anpassung des Docker-Datenverzeichnisses (`/var/lib/docker`)
- Erstellung eines Basisverzeichnisses für Docker-Compose-Projekte
- Optionales Aktivieren des `docker`-Plugins in der OhMyZSH-Konfiguration (`/root/.zshrc`)
- Kompatibel mit Ubuntu **22.04 Jammy** und **24.04 Noble**

---

## 🔧 Konfigurierbare Variablen

Im Skriptkopf kannst du folgende Variablen anpassen:

| Variable             | Beschreibung                                                                 | Wert                         |
|----------------------|------------------------------------------------------------------------------|------------------------------|
| `USER`               | Der Benutzer, dem Docker-Rechte zugewiesen werden sollen                     | `root`                       |
| `COMPOSEVERSION`     | Die zu installierende Docker-Compose-Version                                 | `v2.37.1`                    |
| `DOCKER_ROOT_DIR`    | Zielverzeichnis für Docker-Daten                                             | `/var/lib/docker`            |
| `COMPOSE_DIR`        | Verzeichnis für zukünftige Compose-Projekte                                  | `/home/docker-projekte`      |
| `ENABLE_ZSH_PLUGIN`  | Aktiviert das OhMyZSH-Plugin für Docker                                      | `true` / `false`             |

---

## ▶️ Ausführung

```bash
# 1. Skript herunterladen (z. B. mit wget)
wget https://git.techniverse.net/scriptos/linux-docker-installer/raw/branch/main/docker-installer-ubuntu.v3.sh

# 2. Ausführbar machen
chmod +x docker-installer-ubuntu.v3.sh

# 3. Als root oder mit sudo ausführen
sudo bash ./docker-installer-ubuntu.v3.sh
```

[![asciicast](https://asciinema.it-nerds.com/a/53.svg)](https://asciinema.it-nerds.com/a/53)

---

## 🔗 Repository

Mehr unter: [https://www.cleveradmin.de](https://www.cleveradmin.de)  
Source: [https://git.techniverse.net/scriptos/public-linux-docker-installer](https://git.techniverse.net/scriptos/public-linux-docker-installer)

---

## 💬 Support & Community

Du hast Fragen, brauchst Unterstützung bei der Einrichtung oder möchtest dich einfach mit anderen austauschen, die ähnliche Projekte betreiben? Dann schau gerne in unserer Techniverse Community vorbei:

👉 **Matrix-Raum:** [#community:techniverse.net](https://matrix.to/#/#community:techniverse.net)  
Wir freuen uns auf deinen Besuch und helfen dir gerne weiter!

<p align="center">
  <img src="https://assets.techniverse.net/f1/git/graphics/gray0-catonline.svg" alt="">
</p>

<p align="center">
<img src="https://assets.techniverse.net/f1/logos/small/license.png" alt="License" width="15" height="15"> <a href="./public-linux-docker-installer/src/branch/main/LICENSE">License</a> | <img src="https://assets.techniverse.net/f1/logos/small/matrix2.svg" alt="Matrix" width="15" height="15"> <a href="https://matrix.to/#/#community:techniverse.net">Matrix</a> | <img src="https://assets.techniverse.net/f1/logos/small/mastodon2.svg" alt="Matrix" width="15" height="15"> <a href="https://social.techniverse.net/@donnerwolke">Mastodon</a>
</p>