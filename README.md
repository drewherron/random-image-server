# Random Image Server

A simple, secure Nginx-based server that displays a random image on each page load.

## Features

- Displays random images at fixed dimensions
- Secure by default with Docker isolation
- Rate limiting to prevent abuse
- Easy to customize and deploy
- Multiple deployment options (Docker or direct installation)

## Security Features

- **Non-root execution**: Runs as unprivileged 'nobody' user
- **Rate limiting**: Protects against DoS attacks (configurable, default: 30 req/min)
- **Security headers**: Implements modern web security headers
- **Safe file access**: Uses LuaFS instead of shell commands
- **Input validation**: Proper file extension validation
- **Restricted file types**: Only serves approved image formats
- **No directory traversal**: Path sanitization to prevent unauthorized access
- **Limited server info**: Hides server version information
- **Container isolation**: Docker provides additional security boundary

## Deployment Options

### Option 1: Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/drewherron/random-image-server.git
cd random-image-server

# Create and configure .env file
cp .env.example .env
nano .env  # Edit configuration as needed

# Create images directory and add your images
mkdir -p images
cp /path/to/your/images/* images/

# Start the server
docker-compose -f docker/docker-compose.yml up -d
```

### Option 2: Direct Installation

For servers where you prefer not to use Docker:

```bash
# Clone the repository
git clone https://github.com/drewherron/random-image-server.git
cd random-image-server

# Run the installation script (requires root privileges)
sudo ./scripts/install.sh /path/to/your/images

# The script will:
# - Install required packages (nginx-extras, lua modules)
# - Configure Nginx with the random image server
# - Set proper file permissions
```

Visit http://localhost to see a random image.

## Configuration

### Docker Configuration
Edit `.env` file to customize:
- `IMAGE_DIR` - Path to your images directory
- `PORT` - Port to serve content (default: 80)
- `IMAGE_WIDTH` - Width of displayed images
- `IMAGE_HEIGHT` - Height of displayed images
- `RATE_LIMIT` - Rate limiting (requests per minute)
- `SERVER_NAME` - Domain name or IP address
- `ENABLE_HTTPS` - Enable/disable HTTPS

### Script Utilities

This repository includes two utility scripts:

- `scripts/install.sh` - Installs and configures the server directly on a Linux system
  - Usage: `sudo ./scripts/install.sh [image_directory]`
  - Automatically detects Debian/Ubuntu or RHEL/CentOS/Fedora
  
- `scripts/setup-permissions.sh` - Sets correct file permissions for your image directory
  - Usage: `sudo ./scripts/setup-permissions.sh [image_directory] [nginx_user]`
  - Runs automatically during installation

## Security Best Practices

When deploying this server, consider these additional security measures:

1. **Firewall configuration**: Restrict access to the server if it doesn't need to be publicly accessible
2. **Regular updates**: Keep your system, Docker, and Nginx updated
3. **HTTPS**: For public deployments, enable HTTPS using the configuration options
4. **Custom ports**: Change the default port from 80 to a non-standard port for added security
5. **Content filtering**: Only host images you've personally verified
6. **Access logs**: Monitor access logs for suspicious activity
7. **Resource limits**: Set Docker resource limits to prevent container escape or DoS

For production deployments, consider placing the server behind a reverse proxy like Cloudflare or Nginx Proxy Manager for additional protection.
