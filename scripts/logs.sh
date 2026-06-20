#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " MTProxy Logs"
echo "======================================"

# Ensure Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed."
    exit 1
fi

# Ensure Docker Compose service exists
if ! docker compose ps >/dev/null 2>&1; then
    echo "Error: Unable to read Docker Compose services."
    exit 1
fi

echo "Streaming logs (press Ctrl+C to exit)..."
echo

docker compose logs -f --tail=100 mtproxy