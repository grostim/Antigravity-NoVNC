# Guide de Déploiement

Ce document décrit la configuration de déploiement et l'intégration CI/CD pour le projet Antigravity-NoVNC.

## 1. Configuration de l'Infrastructure

Le projet utilise Docker et Docker Compose pour la conteneurisation de l'application.

### 1.1. `Dockerfile`

Le `Dockerfile` définit l'environnement d'exécution de l'application Antigravity.

*   **Image de base**: `accetto/ubuntu-vnc-xfce-chromium-g3:latest`
    *   Fournit un environnement Ubuntu avec VNC, le bureau XFCE et le navigateur Chromium. Cela indique que l'application `antigravity` s'exécute dans un environnement de bureau graphique via VNC.
*   **Installation des dépendances**: Installe diverses bibliothèques système nécessaires au fonctionnement de l'environnement graphique et du navigateur.
*   **Installation d'Antigravity**:
    *   Ajoute un dépôt APT personnalisé pour `antigravity-auto-updater-dev`.
    *   Installe le paquet `antigravity`, qui est l'application principale.
*   **Gestion des permissions**: Configure les permissions pour l'utilisateur `headless` (UID 1001) et les répertoires de démarrage.
*   **Commande de démarrage (CMD)**:
    *   Exécute le script `startup.sh`, qui à son tour lance l'application `antigravity` avec des drapeaux spécifiques (`--no-sandbox`, `--disable-dev-shm-usage`).

### 1.2. `docker-compose.yml`

Le fichier `docker-compose.yml` orchestre le déploiement du service `antigravity`.

*   **Version**: `3.8` de la spécification Docker Compose.
*   **Service**: `antigravity`
    *   **Image**: `ghcr.io/grostim/antigravity-novnc:1.2` (l'image construite à partir du `Dockerfile`).
    *   **Nom du conteneur**: `antigravity_browser`.
    *   **Mémoire partagée (`shm_size`)**: `2gb`, recommandée pour les applications basées sur Chromium/Electron.
    *   **Ports**:
        *   `6901:6901`: Accès HTTP à noVNC (interface web pour VNC).
        *   `5901:5901`: Port VNC standard.
    *   **Volumes**: `./work:/home/headless/Documents/work` pour la persistance des fichiers de travail de l'utilisateur `headless`.
    *   **Variables d'environnement**: `VNC_RESOLUTION` (1600x900) et `VNC_PW` (antigravity) pour la configuration VNC.
    *   **Politique de redémarrage**: `unless-stopped`, le conteneur redémarrera automatiquement sauf s'il est explicitement arrêté.

## 2. Intégration Continue / Déploiement Continu (CI/CD)

Le projet utilise GitHub Actions pour son pipeline CI/CD, configuré dans le répertoire `.github/workflows/`.

### 2.1. `check-updates.yml`

Ce workflow est responsable de la vérification des mises à jour. (Détails à extraire du fichier si nécessaire)

### 2.2. `docker-publish.yml`

Ce workflow est configuré pour construire et publier automatiquement l'image Docker vers le **GitHub Container Registry** (`ghcr.io`) lors d'un push sur la branche `main` ou la création d'un tag. Il déclenche la construction de l'image Docker à partir du `Dockerfile` et son push vers le registre spécifié.

## 3. Script de Démarrage

### 3.1. `startup.sh`

Ce script simple est exécuté au démarrage du conteneur et effectue les actions suivantes :

*   **Correction des permissions**: S'assure que les permissions sont correctement définies pour l'utilisateur `headless` sur les volumes montés.
*   **Exécution de l'application**: Transfère le contrôle à la commande principale de l'application (`antigravity`) passée en argument, avec les options spécifiées.

## Conclusion

L'infrastructure de ce projet est basée sur Docker, déployant une application de bureau (`antigravity`) via un environnement VNC accessible à distance. Le processus CI/CD est géré par GitHub Actions pour la vérification des mises à jour et la publication des images Docker.
