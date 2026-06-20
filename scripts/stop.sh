#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Stopping MTProxy"
echo "======================================"

# Check that Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed."
    exit 1
fi

# Stop and remove containers defined in docker-compose.yml
docker compose down

echo
echo "MTProxy has been stopped successfully."

echo
echo "Current container status:"
docker compose ps