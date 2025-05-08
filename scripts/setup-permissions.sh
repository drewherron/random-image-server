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

# Set ownership
echo "Setting ownership of $IMAGE_DIR to $NGINX_USER"
chown -R $NGINX_USER:$NGINX_USER "$IMAGE_DIR"

# Set permissions
echo "Setting secure permissions"
find "$IMAGE_DIR" -type d -exec chmod 755 {} \;
find "$IMAGE_DIR" -type f -exec chmod 644 {} \;

# Add sample image if directory is empty
if [ -z "$(ls -A $IMAGE_DIR)" ]; then
    echo "Directory is empty, adding a sample image"

    # Check if we have sample images in repo
    if [ -d "sample-images" ] && [ -n "$(ls -A sample-images)" ]; then
        cp sample-images/* "$IMAGE_DIR/"
    else
        # Create a simple text file if no samples exist
        echo "No sample images available. Please add your own images." > "$IMAGE_DIR/README.txt"
    fi
fi