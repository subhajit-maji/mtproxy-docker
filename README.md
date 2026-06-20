# MTProxy Docker

A simple, production-ready Telegram MTProxy deployment using Docker.

## Features

- ✅ Docker-based deployment
- ✅ Supports Telegram MTProxy
- ✅ Custom secret support
- ✅ Promotion tag support
- ✅ Uses port 443
- ✅ Automatic restart (`unless-stopped`)
- ✅ Compatible with Ubuntu 20.04, 22.04 and 24.04
- ✅ Can be used with either a public IP or a DNS hostname
- ✅ Easy to maintain and update

## Requirements

- Linux server (Ubuntu recommended)
- Docker installed
- TCP port `443` open in the firewall and cloud security rules
- Public IPv4 address
- (Optional) Domain name pointing to the server

## Clone

```bash
git clone https://github.com/subhajit-maji/mtproxy-docker.git
cd mtproxy-docker
```

## Configuration

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Edit `.env`:

```text
SECRET=YOUR_SECRET
TAG=YOUR_PROMOTION_TAG
```

## Prerequisites

- Docker Engine installed
- Docker Compose v2 plugin installed

On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y docker-compose-v2
```

Verify the installation:

```bash
docker compose version
```

## Start

```bash
docker compose up -d
```

## Stop

```bash
docker compose down
```

## Restart

```bash
docker compose restart
```

## View logs

```bash
docker compose logs -f
```

## Verify

Check that the container is running:

```bash
docker ps
```

Check that port 443 is listening:

```bash
sudo ss -ltnp | grep :443
```

## Telegram proxy links

Using an IP address:

```
tg://proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

Using a domain name:

```
tg://proxy?server=YOUR_DOMAIN&port=443&secret=YOUR_SECRET
```

## Cloudflare DNS

If using Cloudflare:

- Create an **A** record pointing to your server IP.
- Set the record to **DNS only** (grey cloud).
- Do **not** enable Cloudflare proxying for MTProxy traffic.

## Troubleshooting

### Domain resolves but Telegram cannot connect

- Confirm the domain points to the correct server IP.
- Confirm TCP port 443 is open.
- Confirm Docker is running.
- Confirm the MTProxy container is healthy.
- If using Cloudflare, ensure the DNS record is **DNS only**.

### Connection refused

Check:

```bash
docker ps
sudo ss -ltnp | grep :443
```

### Container logs

```bash
docker logs mtproxy
```

## Security

- Do not publish your production secret.
- Do not commit your `.env` file to GitHub.
- Use `.env.example` with placeholder values instead.

## Update

Pull the latest changes from the repository and recreate the container:

```bash
git pull
docker compose pull
docker compose up -d
```

## Repository Structure

```text
.
├── .env.example
├── .gitignore
├── CONTRIBUTING.md
├── LICENSE
├── README.md
├── SECURITY.md
├── docker-compose.yml
├── docs/
│   ├── setup.md
│   └── cloudflare-dns.md
└── scripts/
    ├── install.sh
    ├── start.sh
    ├── stop.sh
    ├── restart.sh
    └── logs.sh
```

## License

MIT
