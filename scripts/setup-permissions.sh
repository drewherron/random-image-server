#!/bin/bash
set -e

# Configuration
IMAGE_DIR=${1:-/var/www/images}
NGINX_USER=${2:-www-data}

echo "Starting permissions setup..."