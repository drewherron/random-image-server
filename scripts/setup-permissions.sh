#!/bin/bash
set -e

# Configuration
IMAGE_DIR=${1:-/var/www/images}
NGINX_USER=${2:-www-data}

echo "Starting permissions setup..."

# Check if directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Creating directory $IMAGE_DIR"
    mkdir -p "$IMAGE_DIR"
fi