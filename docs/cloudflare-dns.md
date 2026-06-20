# Cloudflare DNS Configuration for MTProxy

This guide explains how to configure Cloudflare DNS when using MTProxy.

## Create an A Record

| Type | Name | Value | Proxy Status |
|------|------|-------|--------------|
| A | proxy | YOUR_SERVER_IP | **DNS only** |

Example:

| Type | Name | Value | Proxy Status |
|------|------|-------|--------------|
| A | proxy | 203.0.113.10 | **DNS only** |

## Why "DNS only"?

MTProxy expects clients to connect directly to your server.

If Cloudflare's proxy (orange cloud) is enabled, Telegram clients may fail to connect because traffic is routed through Cloudflare instead of directly to your MTProxy instance.

For this reason, the DNS record used by MTProxy should remain **DNS only**.

## Verify DNS Resolution

Check that the hostname resolves to your server IP:

```bash
dig +short proxy.example.com
```

or

```bash
nslookup proxy.example.com
```

The returned IPv4 address should match your server's public IP.

## Verify Connectivity

Test that port 443 is reachable:

```bash
nc -vz proxy.example.com 443
```

A successful connection indicates that the TCP port is accessible.

## Common Issues

### Domain resolves but Telegram cannot connect

- Ensure the DNS record is set to **DNS only**.
- Verify that TCP port 443 is open.
- Confirm that MTProxy is running.
- Confirm that the domain points to the correct server IP.

### DNS changes are not visible immediately

DNS updates may take time to propagate depending on caching and resolver behavior. If a recent change is not reflected, wait a short period and test again.

## Checklist

- [ ] A record points to the correct public IPv4 address
- [ ] Proxy status is **DNS only**
- [ ] Port 443 is open
- [ ] Docker container is running
- [ ] MTProxy is listening on port 443
- [ ] Telegram link uses the correct hostname and secret