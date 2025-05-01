#!/bin/bash
set -e

# Configuration
IMAGE_DIR=${1:-/var/www/images}
NGINX_CONF_DIR=/etc/nginx/conf.d
REPO_DIR=$(pwd)

# Create images directory if it doesn't exist
mkdir -p $IMAGE_DIR

echo "Basic setup complete!"