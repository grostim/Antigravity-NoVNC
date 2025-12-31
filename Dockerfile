# Utilisation de l'image de base accetto/ubuntu-vnc-xfce-chromium-g3
# Cette image inclut déjà Ubuntu, XFCE, VNC, noVNC et Chromium
FROM accetto/ubuntu-vnc-xfce-chromium-g3:latest

# Passer en utilisateur root pour l'installation des paquets
USER 0

# Installation des dépendances pour Electron/Antigravity et utilitaires
RUN apt-get update && apt-get install -y \
    libnss3 \
    libasound2t64 \
    libgbm1 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxss1 \
    libxtst6 \
    curl \
    lsb-release \
    xdg-utils \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Création du dossier de travail pour l'application
WORKDIR /app

# Copie du script de démarrage personnalisé
COPY startup.sh /dockerstartup/custom_startup.sh
RUN chmod +x /dockerstartup/custom_startup.sh

# Automation: Installation depuis le dépôt APT officiel
# Le dépôt est hébergé sur Google Artifact Registry
RUN echo "deb [trusted=yes] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" > /etc/apt/sources.list.d/antigravity.list \
    && apt-get update \
    && apt-get install -y antigravity \
    && rm -rf /var/lib/apt/lists/*


# Revenir à l'utilisateur par défaut 'headless'
USER 1001

# Définition du script de démarrage par défaut
ENTRYPOINT ["/dockerstartup/custom_startup.sh"]
