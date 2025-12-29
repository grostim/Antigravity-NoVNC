#!/bin/bash
# startup.sh - Script de démarrage personnalisé

# Démarrer le serveur VNC/noVNC en arrière-plan (utilisation du script de l'image de base)
/dockerstartup/vnc_startup.sh -w &

# Attendre quelques secondes pour que XFCE démarre
sleep 5

echo "Lancement de Google Antigravity..."

# Lancer Antigravity
# --no-sandbox est nécessaire pour tourner dans Docker sans privilèges élevés
# --disable-gpu peut aider à la stabilité selon l'hôte
# Les données utilisateur sont stockées dans le volume monté si configuré
exec google-antigravity --no-sandbox --disable-dev-shm-usage "$@"
