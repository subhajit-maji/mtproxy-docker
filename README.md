# 🚀 Telegram MTProxy Server with Docker

Deploy a Telegram MTProxy server on Ubuntu using Docker in a few minutes.

## Features

- ✅ Docker-based deployment
- ✅ Runs on port 443 (recommended)
- ✅ Supports Telegram promotion tags
- ✅ Automatic restart on reboot
- ✅ Compatible with Ubuntu 22.04+ and 24.04+
- ✅ Simple management commands

---

# 1. Requirements

- Ubuntu VPS (22.04 or newer)
- Docker installed (or install using the steps below)
- Public IPv4 address
- TCP port **443** open in your cloud firewall and local firewall

---

# 2. Install Docker

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
docker --version
```

---

# 3. Open Firewall

```bash
sudo ufw allow 443/tcp
sudo ufw reload
sudo ufw status
```

---

# 4. Stop Any Service Using Port 443

Check:

```bash
sudo ss -ltnp | grep :443
```

If Nginx is using port 443:

```bash
sudo systemctl stop nginx
sudo systemctl disable nginx
```

---

# 5. Run MTProxy

Replace:

- `YOUR_SECRET` with your 32-character hexadecimal secret.
- `YOUR_PROMOTION_TAG` with your Telegram promotion tag (optional).

```bash
sudo docker run -d \
  --name mtproxy \
  --restart unless-stopped \
  -p 443:443 \
  -e SECRET=YOUR_SECRET \
  -e TAG=YOUR_PROMOTION_TAG \
  telegrammessenger/proxy:latest
```

---

# 6. Verify Container

```bash
sudo docker ps
```

Expected output should show:

```
0.0.0.0:443->443/tcp
```

---

# 7. Check Logs

```bash
sudo docker logs --tail 50 mtproxy
```

You should see output similar to:

```
Tag: YOUR_PROMOTION_TAG
External IP: YOUR_SERVER_IP
Starting proxy...
```

---

# 8. Verify Port 443

```bash
sudo ss -ltnp | grep :443
```

Expected:

```
LISTEN 0 4096 0.0.0.0:443
```

---

# 9. Test Locally

```bash
nc -vz 127.0.0.1 443
```

Expected:

```
Connection succeeded
```

---

# 10. Test from the Internet

```bash
nc -vz YOUR_SERVER_IP 443
```

Expected:

```
Connection succeeded
```

---

# 11. Create Telegram Proxy Link

```
https://t.me/proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

Direct link:

```
tg://proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_SECRET
```

---

# 12. Optional: Use a Domain Name

Create an **A** record:

| Type | Name | Value |
|------|------|-------|
| A | proxy | YOUR_SERVER_IP |

If using Cloudflare:

- Proxy Status: **DNS only**
- Do **not** enable the orange-cloud reverse proxy.

Verify:

```bash
dig +short proxy.example.com
```

Expected:

```
YOUR_SERVER_IP
```

---

# 13. Docker Management

## View running container

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

# 14. Update to Latest Image

```bash
sudo docker pull telegrammessenger/proxy:latest

sudo docker rm -f mtproxy

sudo docker run -d \
  --name mtproxy \
  --restart unless-stopped \
  -p 443:443 \
  -e SECRET=YOUR_SECRET \
  -e TAG=YOUR_PROMOTION_TAG \
  telegrammessenger/proxy:latest
```

---

# 15. Common Checks

## Is Docker running?

```bash
sudo docker ps
```

## Is port 443 listening?

```bash
sudo ss -ltnp | grep :443
```

## Is UFW allowing 443?

```bash
sudo ufw status
```

## Does DNS resolve?

```bash
dig +short proxy.example.com
```

## Is the port reachable?

```bash
nc -vz proxy.example.com 443
```

---

# 16. Troubleshooting

### Telegram says "Unavailable"

- Ensure MTProxy is running.
- Confirm port 443 is open in both UFW and your cloud provider's firewall.
- Verify the DNS A record points to the correct public IP.
- If using Cloudflare, set the DNS record to **DNS only**.
- Double-check that the secret in the Telegram link exactly matches the server configuration.

### Promotion tag not working

- Start the container with the correct `TAG` value.
- Check the logs:

```bash
sudo docker logs mtproxy
```

You should see:

```
Tag: YOUR_PROMOTION_TAG
```

---

# 17. Security Tips

- Use a strong, random 32-character hexadecimal secret.
- Keep your operating system updated.
- Restrict SSH access and use key-based authentication.
- Monitor Docker logs for unusual activity.
- Regularly back up your deployment configuration.

---

# License

This project is provided under the MIT License.
