# Antigravity Portable (Docker + noVNC)

This project provides a portable version of **Google Antigravity** that can be executed in any web browser thanks to Docker and noVNC. It deploys a complete isolated desktop environment (XFCE).

## 📋 Prerequisites

1.  **Docker** and **Docker Compose** installed on your machine.

## 🚀 Quick Start

1.  **Start the container**:

    We recommend using the pre-built image from the GitHub Container Registry.

    ```bash
    docker-compose up -d
    ```

    _Note: The Antigravity download (approx. 100MB) will happen automatically during the first startup if not already present in the image._

2.  **Access the application**:
    - Open your browser at: [http://localhost:6901](http://localhost:6901)
    - Default VNC password: `antigravity`
    - If requested, the user password (root) for `sudo` commands is the same as the VNC user (often `headless` or empty depending on the base config, but you are logged in as a standard user).

## 📂 Data Persistence

A volume is configured to save your working files outside the container.

- **Local directory**: `./work` (automatically created at the project root).
- **Directory inside container**: `/home/headless/Documents/work`.

Everything you save in this folder from within Antigravity will be preserved on your host machine even after the container is stopped.

## 🛠️ Manual Build (Optional)

If you prefer to build the image yourself instead of using the pre-built one:

```bash
# 1. Build the image
docker build -t antigravity-portable .

# 2. Run the container
docker run -it -p 6901:6901 -p 5901:5901 \
    -v $(pwd)/work:/home/headless/Documents/work \
    --shm-size=2g \
    antigravity-portable
```

## ⚙️ Advanced Configuration

You can modify `docker-compose.yml` to adjust:

- **Resolution**: Change `VNC_RESOLUTION=1600x900` to match your screen.
- **Password**: Change `VNC_PW=...` (Warning: this is not secure for public deployment).
- **Ports**: Modify the `6901:6901` mapping if the port is already in use.

## 🤖 CI/CD

A GitHub Actions workflow is included in `.github/workflows/docker-publish.yml`. It is configured to automatically build and publish the image to the **GitHub Container Registry** upon a push to `main` or tag creation.

**Note**: Installation is automatically handled by the Dockerfile via the official APT repository, no manual steps are required.

## ❓ Troubleshooting

- **Black screen?** Refresh the page or wait a few seconds for XFCE to finish loading.
- **Antigravity not starting?** Check the logs: `docker-compose logs antigravity`.
- **Permissions?** If you cannot write to the `work` folder, check the permissions of the `./work` folder on your host machine (`chmod 777 work` to test).

> **Fun Fact**: This Docker image was designed by Antigravity itself. Who needs humans anyway? 🤖✨
