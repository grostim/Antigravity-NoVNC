# Analyse de l'Arborescence du Code Source

Voici l'arborescence des répertoires du projet Antigravity-NoVNC, annotée avec des descriptions pour une meilleure compréhension.

```
/
├── .github/                       # Contient les configurations des workflows GitHub Actions pour l'intégration et le déploiement continus (CI/CD).
│   ├── workflows/                 # Répertoire standard pour les définitions de workflows GitHub Actions.
│   │   ├── check-updates.yml      # Workflow pour vérifier les mises à jour et les dépendances du projet.
│   │   └── docker-publish.yml     # Workflow pour construire et publier l'image Docker du projet vers un registre.
├── antigravity-version.txt        # Fichier texte contenant la version de l'application Antigravity.
├── docker-compose.yml             # Fichier de configuration Docker Compose utilisé pour définir et exécuter les services Docker multi-conteneurs du projet. Il orchestre le déploiement du service Antigravity.
├── Dockerfile                     # Fichier Dockerfile utilisé pour construire l'image Docker de l'application Antigravity-NoVNC. Il spécifie l'environnement de base, les dépendances et les étapes d'installation de l'application.
├── README.md                      # Fichier d'informations générales sur le projet, incluant une description, les instructions d'installation et d'utilisation.
└── startup.sh                     # Script shell exécuté au démarrage du conteneur pour configurer l'environnement (ex: permissions) et lancer l'application principale.
```
