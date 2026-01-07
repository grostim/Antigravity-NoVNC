# Architecture du Projet Antigravity-NoVNC

Ce document décrit l'architecture du projet Antigravity-NoVNC, une application de bureau conteneurisée et accessible à distance.

## 1. Résumé Exécutif

Le projet Antigravity-NoVNC fournit une version portable de l'application Google Antigravity, exécutable via un navigateur web. L'architecture est basée sur la conteneurisation Docker, déployant un environnement de bureau Linux (XFCE) avec l'application Antigravity, le tout rendu accessible à distance grâce à noVNC.

## 2. Pile Technologique

Le projet s'appuie sur la pile technologique suivante :

*   **Conteneurisation**: Docker, Docker Compose
    *   **Justification**: Utilisation de `Dockerfile` et `docker-compose.yml` pour la définition et l'orchestration de l'environnement d'exécution.
*   **Système d'exploitation de base**: Ubuntu
    *   **Justification**: L'image Docker est basée sur `accetto/ubuntu-vnc-xfce-chromium-g3:latest`.
*   **Environnement de bureau**: XFCE
    *   **Justification**: Fourni par l'image de base `accetto/ubuntu-vnc-xfce-chromium-g3`.
*   **Accès à distance**: VNC, noVNC
    *   **Justification**: L'image de base intègre un serveur VNC et les ports sont exposés pour l'accès VNC et noVNC.
*   **Moteur de rendu / Runtime**: Chromium (potentiellement Electron)
    *   **Justification**: L'image de base inclut Chromium, et l'application Antigravity utilise probablement ce moteur pour son interface. Les flags `--no-sandbox` et `--disable-dev-shm-usage` pour Antigravity sont typiques des applications basées sur Chromium/Electron.
*   **Application Cœur**: Antigravity
    *   **Justification**: L'application est installée via un dépôt APT personnalisé et est l'exécutable principal lancé dans le conteneur.
*   **Scripting**: Bash
    *   **Justification**: Utilisation du script `startup.sh` pour la configuration et le démarrage de l'application dans le conteneur.

## 3. Modèle Architectural

L'architecture peut être décrite comme une **application de bureau conteneurisée avec accès à distance**. Plutôt qu'une architecture client-serveur traditionnelle pour le développement web, il s'agit d'une application de bureau "streamée" via VNC/noVNC.

## 4. Arborescence du Code Source

L'arborescence du projet reflète sa nature conteneurisée et son intégration CI/CD :

```
/
├── .github/                       # Workflows GitHub Actions (CI/CD)
│   ├── workflows/
│   │   ├── check-updates.yml      # Vérification des mises à jour
│   │   └── docker-publish.yml     # Publication des images Docker
├── antigravity-version.txt        # Version de l'application Antigravity
├── docker-compose.yml             # Orchestration des services Docker
├── Dockerfile                     # Définition de l'image Docker
├── README.md                      # Documentation générale du projet
└── startup.sh                     # Script de démarrage du conteneur
```

## 5. Architecture de Déploiement

Le déploiement est entièrement géré par Docker et Docker Compose.

*   **Conteneurisation**: L'application est empaquetée dans une image Docker qui inclut toutes ses dépendances et son environnement d'exécution.
*   **Orchestration Locale**: `docker-compose.yml` permet de démarrer l'application comme un service conteneurisé, en exposant les ports VNC et HTTP (noVNC).
*   **CI/CD**: GitHub Actions (`.github/workflows/docker-publish.yml`) automatise la construction et la publication de l'image Docker vers le GitHub Container Registry, assurant une livraison continue des nouvelles versions.

## 6. Flux de Travail de Développement

Le développement est centré sur la gestion de l'image Docker et de ses dépendances.

*   **Démarrage Local**: `docker-compose up -d` pour lancer l'environnement de développement complet.
*   **Construction Manuelle**: Possibilité de reconstruire l'image localement via `docker build`.
*   **Persistance**: Utilisation d'un volume (`./work`) pour la persistance des données de l'application en dehors du conteneur.

## 7. Stratégie de Test

Aucune stratégie de test formelle n'a été identifiée dans la structure du projet. Les tests sont probablement manuels ou intégrés dans le processus de développement et de déploiement via des vérifications post-déploiement.
