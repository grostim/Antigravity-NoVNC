# Utilisation de l'image de base accetto/ubuntu-vnc-xfce-chromium-g3
# Cette image inclut déjà Ubuntu, XFCE, VNC, noVNC et Chromium
FROM accetto/ubuntu-vnc-xfce-chromium-g3:latest

# Passer en utilisateur root pour l'installation des paquets
USER 0

# Installation des dépendances pour Electron/Antigravity et utilitaires
RUN apt-get update && apt-get install -y \
    libnss3 \
    libasound2 \
    libgbm1 \
    libgconf-2-4 \
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

# Téléchargement automatique de Antigravity
# On utilise wget pour récupérer le paquet depuis l'URL officielle
RUN wget -q -O /app/google-antigravity.deb https://antigravity.google/download/linux

# Installation de Antigravity
RUN dpkg -i /app/google-antigravity.deb || apt-get install -f -y

# Revenir à l'utilisateur par défaut 'headless'
USER 1001

# Définition du script de démarrage par défaut
ENTRYPOINT ["/dockerstartup/custom_startup.sh"]
