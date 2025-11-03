#!/bin/bash
set -e

echo "🔨 Building custom n8n runners image with additional Python libraries..."

# Try different Docker Compose commands
if command -v docker-compose &> /dev/null; then
    echo "Using docker-compose..."
    docker-compose build task-runners
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    echo "Using docker compose..."
    docker compose build task-runners
else
    echo "❌ Docker or Docker Compose not found!"
    echo "Please ensure Docker is installed and running."
    echo "You can manually build with:"
    echo "  docker build -f Dockerfile.runners -t custom-n8n-runners ."
    exit 1
fi

echo "✅ Custom n8n runners image built successfully!"
echo ""
echo "📦 Installed Python libraries:"
echo "  - requests (HTTP client)"
echo "  - pandas (data manipulation)"
echo "  - matplotlib (plotting)"
echo "  - json, collections, time, datetime (built-in)"
echo ""
echo "🚀 To restart with the new image:"
echo "  docker-compose down && docker-compose up -d"
echo "  OR"
echo "  docker compose down && docker compose up -d"