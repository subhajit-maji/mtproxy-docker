# Security Policy

## Supported Versions

This repository is maintained on a best-effort basis. Users are encouraged to stay up to date with the latest commit and regularly update Docker images and system packages.

| Version | Supported |
|----------|-----------|
| Latest   | ✅ Yes |
| Older releases | ❌ No guarantee |

## Reporting a Security Issue

If you discover a security vulnerability related to this repository:

1. Do not publish sensitive details, secrets, or exploit code in a public issue.
2. Contact the repository maintainer privately if possible.
3. Include enough information to reproduce and understand the issue.
4. Allow reasonable time for review before public disclosure.

## Security Best Practices

- Never commit `.env` files or secrets to version control.
- Generate a unique MTProxy secret for your deployment.
- Restrict SSH access and use strong authentication.
- Keep Docker, the operating system, and dependencies up to date.
- Limit access to management interfaces and monitor logs regularly.
- Review firewall rules and expose only the ports that are required.

## Secrets Management

Store configuration values such as MTProxy secrets outside the repository (for example, in a local `.env` file that is ignored by Git).

## Disclaimer

This project is provided "as is" without warranties or guarantees. Users are responsible for securing and operating their own infrastructure in accordance with their environment and requirements.