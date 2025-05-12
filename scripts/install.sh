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

# Create directories if they don't exist
echo "Setting up directories..."
mkdir -p $IMAGE_DIR
mkdir -p /var/www/static

# Copy static files
echo "Copying static files..."
cp -r $REPO_DIR/static/* /var/www/static/

# Copy configuration files
echo "Copying configuration files..."
cp $REPO_DIR/nginx/conf.d/random-image.conf $NGINX_CONF_DIR/

# Replace placeholders
echo "Configuring paths..."
sed -i "s|/var/www/images|$IMAGE_DIR|g" $NGINX_CONF_DIR/random-image.conf

# Set up permissions
echo "Setting up permissions..."
bash $REPO_DIR/scripts/setup-permissions.sh $IMAGE_DIR /var/www/static $NGINX_USER

# Restart Nginx
echo "Restarting Nginx..."
if command -v systemctl > /dev/null; then
    systemctl restart nginx
else
    service nginx restart
fi

echo "Installation complete!"
echo "Add your images to $IMAGE_DIR"
echo "Access your random image server at http://localhost"