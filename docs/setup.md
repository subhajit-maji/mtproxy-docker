# MTProxy Setup Guide

This guide explains how to deploy MTProxy using Docker.

## Prerequisites

- Ubuntu 20.04, 22.04, or 24.04
- Docker installed
- Docker Compose available
- A public IPv4 address
- TCP port **443** open in your firewall and cloud provider
- (Optional) A domain name pointing to your server

## 1. Clone the repository

```bash
git clone https://github.com/subhajit-maji/mtproxy-docker.git
cd mtproxy-docker
```

## 2. Create your environment file

```bash
cp .env.example .env
```

Edit `.env` and set your values:

```text
SECRET=YOUR_32_CHARACTER_HEX_SECRET
TAG=YOUR_PROMOTION_TAG
```

## 3. Start the proxy

```bash
docker compose up -d
```

## 4. Verify that it is running

```bash
docker ps
```

You should see the `mtproxy` container in the running state.

## 5. Verify that port 443 is listening

```bash
sudo ss -ltnp | grep :443
```

## 6. Check logs

```bash
docker compose logs -f mtproxy
```

## 7. Telegram connection link

Replace the placeholders below with your own values:

Using an IP address:

```text
tg://proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

Using a domain name:

```text
tg://proxy?server=YOUR_DOMAIN&port=443&secret=YOUR_SECRET
```

## 8. Updating the container

Pull the latest image and recreate the service:

```bash
docker compose pull
docker compose up -d
```

## 9. Stopping the service

```bash
docker compose down
```

## Notes

- Use **DNS only** if your DNS provider offers proxying features.
- Do not publish your production `.env` file.
- Store your MTProxy secret securely.