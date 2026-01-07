# Guide de Développement

Ce guide fournit des instructions pour la mise en place de l'environnement de développement, le lancement de l'application, et les configurations avancées pour le projet Antigravity-NoVNC.

## 1. Prérequis

Avant de commencer, assurez-vous d'avoir les outils suivants installés sur votre machine :

*   **Docker** : Pour la conteneurisation de l'application.
*   **Docker Compose** : Pour l'orchestration des services Docker.

## 2. Démarrage Rapide

La méthode recommandée pour démarrer l'application est d'utiliser l'image pré-construite via Docker Compose.

1.  **Lancer le conteneur** :
    ```bash
    docker-compose up -d
    ```
    _Note : Le téléchargement de l'application Antigravity (environ 100 Mo) se fera automatiquement lors du premier démarrage si l'image ne la contient pas déjà._

2.  **Accéder à l'application** :
    *   Ouvrez votre navigateur web à l'adresse : [http://localhost:6901](http://localhost:6901)
    *   Le mot de passe VNC par défaut est : `antigravity`
    *   Si un mot de passe utilisateur (root) pour les commandes `sudo` est demandé, il est généralement le même que le mot de passe VNC (`antigravity`). L'utilisateur par défaut dans le conteneur est `headless`.

## 3. Persistance des Données

Un volume est configuré pour sauvegarder vos fichiers de travail en dehors du conteneur, assurant ainsi la persistance des données.

*   **Répertoire local (sur votre machine hôte)** : `./work` (sera créé automatiquement à la racine du projet).
*   **Répertoire à l'intérieur du conteneur** : `/home/headless/Documents/work`.

Tout ce que vous sauvegardez dans ce dossier depuis l'application Antigravity sera conservé sur votre machine hôte, même après l'arrêt ou la suppression du conteneur.

## 4. Construction Manuelle (Optionnel)

Si vous souhaitez construire l'image Docker vous-même :

1.  **Construire l'image** :
    ```bash
    docker build -t antigravity-portable .
    ```

2.  **Lancer le conteneur** :
    ```bash
    docker run -it -p 6901:6901 -p 5901:5901 \
        -v $(pwd)/work:/home/headless/Documents/work \
        --shm-size=2g \
        antigravity-portable
    ```

## 5. Configuration Avancée

Le fichier `docker-compose.yml` peut être modifié pour des configurations spécifiques :

*   **Résolution VNC** : Ajustez la variable d'environnement `VNC_RESOLUTION` (par exemple, `VNC_RESOLUTION=1600x900`).
*   **Mot de passe VNC** : Modifiez la variable d'environnement `VNC_PW`.
    _Attention : L'utilisation d'un mot de passe par défaut ou simple n'est pas sécurisée pour un déploiement public._
*   **Ports exposés** : Modifiez les mappages de ports (par exemple, `6901:6901`) si les ports par défaut sont déjà utilisés sur votre machine hôte.

## 6. Dépannage

*   **Écran noir lors de l'accès ?** Actualisez la page ou attendez quelques secondes que l'environnement XFCE se charge complètement.
*   **Antigravity ne démarre pas ?** Vérifiez les logs du conteneur : `docker-compose logs antigravity`.
*   **Problèmes de permissions ?** Si vous ne pouvez pas écrire dans le dossier `work`, vérifiez les permissions du répertoire `./work` sur votre machine hôte (`chmod 777 work` peut être utilisé pour tester, mais n'est pas recommandé pour la production).
