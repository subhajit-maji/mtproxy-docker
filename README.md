# 🚀 Telegram MTProxy with Docker

A simple, reliable guide to deploying your own **Telegram MTProxy** server on Ubuntu using Docker.

This guide is designed for beginners and includes installation, configuration, troubleshooting, and maintenance.

> **Note:** MTProxy is intended to help Telegram clients connect to Telegram's network. Make sure you comply with your local laws and your hosting provider's terms of service.

---

# 📋 Requirements

Before you begin, make sure you have:

- Ubuntu 22.04 or newer
- A VPS or dedicated server with a public IPv4 address
- Root or `sudo` access
- Docker installed (instructions below)
- TCP port **443** allowed in both your VPS firewall and local firewall

---

# 🐳 Step 1: Install Docker

Update your system:

```bash
sudo apt update
sudo apt upgrade -y
```

Install Docker:

```bash
sudo apt install -y docker.io
```

Enable Docker at boot:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Verify installation:

```bash
docker --version
```

---

# 🔑 Step 2: Generate a Secret

Generate a secure 32-character hexadecimal secret:

```bash
openssl rand -hex 16
```

Example:

```
37298839850805c2d744d24df6bc7dde
```

Save this value—you will use it when starting the proxy.

---

# 🔥 Step 3: Open Port 443

If you use UFW:

```bash
sudo ufw allow 443/tcp
sudo ufw reload
sudo ufw status
```

If your VPS provider has a cloud firewall (Azure, AWS, Google Cloud, etc.), make sure it also allows inbound TCP traffic on port **443**.

---

# 🚫 Step 4: Make Sure Port 443 Is Free

Check whether another service is already using port 443:

```bash
sudo ss -ltnp | grep :443
```

If Nginx or Apache is listening on port 443, stop it first:

```bash
sudo systemctl stop nginx
sudo systemctl disable nginx
```

or

```bash
sudo systemctl stop apache2
sudo systemctl disable apache2
```

---

# 🚀 Step 5: Start MTProxy

Basic deployment:

```bash
sudo docker run -d \
  --name mtproxy \
  --restart unless-stopped \
  -p 443:443 \
  -e SECRET=YOUR_SECRET \
  telegrammessenger/proxy:latest
```

If you have a Telegram promotion tag, include it:

```bash
sudo docker run -d \
  --name mtproxy \
  --restart unless-stopped \
  -p 443:443 \
  -e SECRET=YOUR_SECRET \
  -e TAG=YOUR_PROMOTION_TAG \
  telegrammessenger/proxy:latest
```

> `TAG` is optional. Only use it if you have obtained a valid promotion tag.

---

# ✅ Step 6: Verify the Container

List running containers:

```bash
sudo docker ps
```

You should see something similar to:

```
0.0.0.0:443->443/tcp
```

---

# 📄 Step 7: Check Logs

View recent logs:

```bash
sudo docker logs --tail 50 mtproxy
```

Follow logs in real time:

```bash
sudo docker logs -f mtproxy
```

---

# 🔌 Step 8: Confirm Port 443 Is Listening

```bash
sudo ss -ltnp | grep :443
```

Expected output:

```
LISTEN 0 4096 0.0.0.0:443
```

---

# 🧪 Step 9: Test Connectivity

Local test:

```bash
nc -vz 127.0.0.1 443
```

Remote test:

```bash
nc -vz YOUR_SERVER_IP 443
```

Both should report a successful connection.

---

# 📱 Step 10: Connect Telegram

Replace the placeholders below:

```
Server: YOUR_SERVER_IP
Port: 443
Secret: YOUR_SECRET
```

You can also create links in this format:

```
https://t.me/proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

or

```
tg://proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

---

# 🌐 Optional: Use a Domain Name

Create an **A** record pointing to your server:

| Type | Name | Value |
|------|------|-------|
| A | proxy | YOUR_SERVER_IP |

Example:

```
proxy.example.com → 203.0.113.10
```

If you use Cloudflare:

- ✅ Set the record to **DNS only**
- ❌ Do **not** enable the reverse proxy (orange cloud)

Verify DNS:

```bash
dig +short proxy.example.com
```

---

# 🛠 Docker Management

## Show running containers

```bash
sudo docker ps
```

## View logs

```bash
sudo docker logs -f mtproxy
```

## Restart

```bash
sudo docker restart mtproxy
```

## Stop

```bash
sudo docker stop mtproxy
```

## Start

```bash
sudo docker start mtproxy
```

## Remove

```bash
sudo docker rm -f mtproxy
```

---

# 🔄 Update MTProxy

Pull the latest image:

```bash
sudo docker pull telegrammessenger/proxy:latest
```

Recreate the container using your existing configuration.

---

# 🩺 Troubleshooting

## Telegram shows "Unavailable"

- Ensure the container is running:
  ```bash
  sudo docker ps
  ```
- Confirm port 443 is open:
  ```bash
  sudo ss -ltnp | grep :443
  ```
- Verify UFW allows TCP 443:
  ```bash
  sudo ufw status
  ```
- Check your cloud firewall rules.
- Confirm your DNS record points to the correct public IP.
- If using Cloudflare, ensure the record is **DNS only**.
- Double-check that the secret in the Telegram client matches the server configuration exactly.

## Browser cannot open the server

MTProxy is **not a website**. Browsing to `https://YOUR_SERVER_IP` or `https://your-domain` may time out or show certificate-related errors because MTProxy does not serve normal HTTPS pages.

---

# 🔒 Security Tips

- Generate a strong random secret.
- Keep Ubuntu updated:
  ```bash
  sudo apt update && sudo apt upgrade
  ```
- Enable automatic container restarts.
- Use SSH keys instead of passwords where possible.
- Review Docker logs periodically.

---

# 📚 Useful Commands

```bash
# Running containers
sudo docker ps

# Follow logs
sudo docker logs -f mtproxy

# Restart
sudo docker restart mtproxy

# Stop
sudo docker stop mtproxy

# Remove
sudo docker rm -f mtproxy

# Check listening ports
sudo ss -ltnp

# Firewall status
sudo ufw status

# DNS lookup
dig +short your-domain.example

# Test connectivity
nc -vz YOUR_SERVER_IP 443
```

---

# 📄 License

This guide is provided under the MIT License. You are free to use, modify, and share it with appropriate attribution.
