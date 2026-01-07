FROM accetto/ubuntu-vnc-xfce-chromium-g3:24.04

USER 0

# Installation des dépendances
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
    git \
    gnome-keyring \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Installation Antigravity
RUN curl -sL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | gpg --dearmor -o /usr/share/keyrings/antigravity-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/antigravity-archive-keyring.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" > /etc/apt/sources.list.d/antigravity.list \
    && apt-get update \
    && apt-get install -y antigravity \
    && rm -rf /var/lib/apt/lists/*

# Fix permissions for headless user
RUN chown -R 1001:1001 /home/headless /dockerstartup \
    && chmod -R 775 /home/headless /dockerstartup

# Configure sudo for headless user
RUN echo "headless ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/headless \
    && chmod 0440 /etc/sudoers.d/headless

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

USER 1001

# L'ENTRYPOINT par défaut de l'image de base s'occupera de VNC.
# On définit simplement la commande à lancer une fois l'environnement prêt via notre script de démarrage.
CMD ["/app/startup.sh", "antigravity", "--no-sandbox", "--disable-dev-shm-usage"]
