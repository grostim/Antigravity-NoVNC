# Aperçu du Projet Antigravity-NoVNC

Ce document offre une vue d'ensemble du projet **Antigravity Portable (Docker + noVNC)**. Il vise à fournir un accès portable à l'application Google Antigravity via une solution conteneurisée et accessible à distance.

## 1. Résumé Exécutif

Antigravity-NoVNC déploie l'application Antigravity de Google dans un environnement de bureau Linux (XFCE) au sein d'un conteneur Docker. L'accès à cet environnement se fait via VNC et une interface web noVNC, permettant une utilisation de l'application depuis n'importe quel navigateur web. Cette approche garantit une portabilité et un isolement de l'environnement d'exécution.

## 2. Pile Technologique Résumée

| Catégorie             | Technologie            |
| :-------------------- | :--------------------- |
| Conteneurisation      | Docker, Docker Compose |
| Système d'exploitation | Ubuntu                 |
| Environnement de Bureau | XFCE                   |
| Accès à distance      | VNC, noVNC             |
| Moteur de Rendu       | Chromium               |
| Application Cœur      | Antigravity            |
| Scripting             | Bash                   |

## 3. Classification de l'Architecture

*   **Type d'Architecture**: Application de bureau conteneurisée avec accès à distance.
*   **Structure du Dépôt**: Monolithe.

## 4. Documentation Détaillée

Pour des informations plus approfondies, veuillez consulter les documents suivants :

*   [Architecture du Projet](./architecture.md)
*   [Guide de Déploiement](./deployment-guide.md)
*   [Guide de Développement](./development-guide.md)
*   [Analyse de l'Arborescence du Code Source](./source-tree-analysis.md)

## 5. Démarrage Rapide

Pour lancer le projet rapidement :

1.  Assurez-vous d'avoir **Docker** et **Docker Compose** installés.
2.  Dans le répertoire racine du projet, exécutez :
    ```bash
    docker-compose up -d
    ```
3.  Accédez à l'application dans votre navigateur via : [http://localhost:6901](http://localhost:6901)
4.  Le mot de passe VNC par défaut est : `antigravity`.
