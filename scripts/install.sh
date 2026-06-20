#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " MTProxy Enterprise - Install Script"
echo "======================================"

# Check for Ubuntu
if ! command -v apt >/dev/null 2>&1; then
    echo "This installer currently supports Ubuntu/Debian-based systems."
    exit 1
fi

echo "Updating package index..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Install Docker if missing
if ! command -v docker >/dev/null 2>&1; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sudo sh
else
    echo "Docker is already installed."
fi

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

echo
echo "Docker version:"
docker --version

echo
echo "Installation completed successfully."
echo
echo "Next steps:"
echo "1. Copy .env.example to .env"
echo "2. Edit .env with your SECRET and TAG"
echo "3. Run: docker compose up -d"