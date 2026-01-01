# Antigravity Portable (Docker + noVNC)

Ce projet fournit une version portable de **Google Antigravity** exécutable dans n'importe quel navigateur web grâce à Docker et noVNC. Il déploie un environnement de bureau complet (XFCE) isolé.

## 📋 Prérequis

1.  **Docker** et **Docker Compose** installés sur votre machine.

## 🚀 Démarrage Rapide

1.  **Lancer le conteneur** :

    ```bash
    docker-compose up -d
    ```

    _Le téléchargement de Antigravity (environ 100Mo) se fera automatiquement lors du premier build._

2.  **Accéder à l'application** :
    - Ouvrez votre navigateur à l'adresse : [http://localhost:6901](http://localhost:6901)
    - Mot de passe VNC par défaut : `antigravity`
    - Si demandé, le mot de passe utilisateur (root) pour les commandes `sudo` est le même que le user VNC (souvent `headless` ou vide selon la config de basse, mais vous êtes logué en user standard).

## 📂 Persistance des Données

Un volume est configuré pour sauvegarder vos fichiers de travail en dehors du conteneur.

- **Dossier local** : `./work` (créé automatiquement à la racine du projet).
- **Dossier dans le conteneur** : `/home/headless/Documents/work`.

Tout ce que vous sauvegardez dans ce dossier depuis Antigravity sera conservé sur votre machine hôte même après l'arrêt du conteneur.

## 🛠️ Build Manuel

Si vous ne souhaitez pas utiliser docker-compose :

```bash
# 1. Construire l'image
docker build -t antigravity-portable .

# 2. Lancer le conteneur
docker run -it -p 6901:6901 -p 5901:5901 \
    -v $(pwd)/work:/home/headless/Documents/work \
    --shm-size=2g \
    antigravity-portable
```

## ⚙️ Configuration Avancée

Vous pouvez modifier `docker-compose.yml` pour ajuster :

- **Résolution** : Changez `VNC_RESOLUTION=1600x900` selon votre écran.
- **Mot de passe** : Changez `VNC_PW=...` (Attention, ceci est peu sécurisé pour un déploiement public).
- **Ports** : Modifiez le mapping `6901:6901` si le port est déjà pris.

## 🤖 CI/CD

Un workflow GitHub Actions est inclus dans `.github/workflows/docker-publish.yml`. Il est configuré pour construire et publier automatiquement l'image sur le **GitHub Container Registry** lors d'un push sur `main` ou la création d'un tag.

**Note** : L'installation est gérée automatiquement par le Dockerfile via le dépôt APT officiel, aucune étape manuelle n'est requise.

## ❓ Dépannage

- **Écran noir ?** Rafraîchissez la page ou attendez quelques secondes que XFCE finisse de charger.
- **Antigravity ne démarre pas ?** Vérifiez les logs : `docker-compose logs antigravity`.
- **Permissions ?** Si vous ne pouvez pas écrire dans le dossier `work`, vérifiez les permissions du dossier `./work` sur votre machine hôte (`chmod 777 work` pour tester).
