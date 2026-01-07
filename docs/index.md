# Index de la Documentation du Projet Antigravity-NoVNC

## Aperçu du Projet

*   **Type**: monolith avec 1 partie(s)
*   **Langage Principal**: Bash/YAML
*   **Architecture**: Application de bureau conteneurisée avec accès à distance

### Référence Rapide

*   **Pile Technologique**: Docker, Docker Compose, Ubuntu, XFCE, VNC/noVNC, Chromium, Antigravity, Bash
*   **Point d'Entrée**: `docker-compose up -d`
*   **Modèle Architectural**: Application de bureau conteneurisée avec accès à distance

## Documentation Générée

*   [Aperçu du Projet](./project-overview.md)
*   [Architecture](./architecture.md)
*   [Analyse de l'Arborescence du Code Source](./source-tree-analysis.md)
*   [Guide de Développement](./development-guide.md)
*   [Guide de Déploiement](./deployment-guide.md)

## Documentation Existante

*   [README.md](./README.md) - Project overview
*   [Check Updates Workflow](./.github/workflows/check-updates.yml) - GitHub Actions workflow for checking updates
*   [Docker Publish Workflow](./.github/workflows/docker-publish.yml) - GitHub Actions workflow for publishing Docker images

## Premiers Pas

Pour lancer le projet rapidement :

1.  Assurez-vous d'avoir **Docker** et **Docker Compose** installés.
2.  Dans le répertoire racine du projet, exécutez :
    ```bash
    docker-compose up -d
    ```
3.  Accédez à l'application dans votre navigateur via : [http://localhost:6901](http://localhost:6901)
4.  Le mot de passe VNC par défaut est : `antigravity`.
