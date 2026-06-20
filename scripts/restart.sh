#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Restarting MTProxy"
echo "======================================"

# Ensure Docker is available
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed."
    exit 1
fi

# Restart the Compose service
docker compose restart

echo
echo "MTProxy restarted successfully."

echo
echo "Service status:"
docker compose ps

echo
echo "Recent logs:"
docker compose logs --tail=20