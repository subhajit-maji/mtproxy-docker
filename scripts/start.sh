#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Starting MTProxy"
echo "======================================"

# Verify Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed."
    exit 1
fi

# Verify Docker Compose configuration
docker compose config >/dev/null

# Start the service
docker compose up -d

echo
echo "MTProxy started successfully."
echo

echo "Running containers:"
docker compose ps

echo
echo "Listening ports:"
sudo ss -ltn | grep ":443" || true

echo
echo "To view logs, run:"
echo "docker compose logs -f"