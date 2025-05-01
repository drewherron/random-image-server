#!/bin/bash
set -e

# Configuration
IMAGE_DIR=${1:-/var/www/images}
NGINX_CONF_DIR=/etc/nginx/conf.d
REPO_DIR=$(pwd)

# Detect OS
if [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    echo "Detected Debian/Ubuntu system"
    apt-get update
    apt-get install -y nginx-extras libnginx-mod-http-lua luarocks
    NGINX_USER="www-data"
elif [ -f /etc/redhat-release ]; then
    # CentOS/RHEL/Fedora
    echo "Detected RHEL/CentOS/Fedora system"
    yum install -y epel-release
    yum install -y nginx-mod-http-lua luarocks
    NGINX_USER="nginx"
else
    echo "Unsupported OS. Please install manually."
    exit 1
fi

# Install Lua dependencies
echo "Installing Lua dependencies..."
luarocks install luafilesystem

# Create images directory if it doesn't exist
echo "Setting up directories..."
mkdir -p $IMAGE_DIR

echo "Lua dependencies and directories set up!"