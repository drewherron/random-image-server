## Under construction, but here's the plan:

# Random Image Server

A simple, secure Nginx-based server that displays a random image on each page load.

## Features

- Displays random images at fixed dimensions
- Secure by default with Docker isolation
- Rate limiting to prevent abuse
- Easy to customize and deploy

## Quick Start

```bash
# Clone the repository
git clone https://github.com/drewherron/random-image-server.git
cd random-image-server

# Add your images to a directory
cp /path/to/your/images/* images/

# Start the server
docker-compose -f docker/docker-compose.yml up -d
```

Visit http://localhost to see a random image.

## Configuration

Edit `.env` file to customize:
- `IMAGE_DIR` - Path to your images directory
- `PORT` - Port to serve content (default: 80)
