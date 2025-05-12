#!/bin/bash
set -e

# Configuration
IMAGE_DIR=${1:-/var/www/images}
STATIC_DIR=${2:-/var/www/static}
NGINX_USER=${3:-www-data}

echo "Starting permissions setup..."

# Check if directories exist
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Creating directory $IMAGE_DIR"
    mkdir -p "$IMAGE_DIR"
fi

if [ ! -d "$STATIC_DIR" ]; then
    echo "Creating directory $STATIC_DIR"
    mkdir -p "$STATIC_DIR"
fi

# Set ownership
echo "Setting ownership of $IMAGE_DIR to $NGINX_USER"
chown -R $NGINX_USER:$NGINX_USER "$IMAGE_DIR"

echo "Setting ownership of $STATIC_DIR to $NGINX_USER"
chown -R $NGINX_USER:$NGINX_USER "$STATIC_DIR"

# Set permissions
echo "Setting secure permissions for images"
find "$IMAGE_DIR" -type d -exec chmod 755 {} \;
find "$IMAGE_DIR" -type f -exec chmod 644 {} \;

echo "Setting secure permissions for static files"
find "$STATIC_DIR" -type d -exec chmod 755 {} \;
find "$STATIC_DIR" -type f -exec chmod 644 {} \;

echo "Permissions setup complete"