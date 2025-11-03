#!/bin/bash
set -e

echo "🔨 Building custom n8n runners image with additional Python libraries..."

# Build the custom image using Docker directly (following working solution)
echo "Step 1: Building custom n8n runner image..."
docker build -f Dockerfile.runners -t n8n-runner:custom .

echo "✅ Custom n8n runners image built successfully!"
echo ""
echo "📦 Installed Python libraries:"
echo "  - requests (HTTP client)"
echo "  - pandas (data manipulation)"  
echo "  - matplotlib (plotting)"
echo "  - numpy (numerical computing)"
echo "  - json, collections, time, datetime, io, base64 (built-in)"
echo ""
echo "🚀 To start with the new image:"
echo "  docker compose up -d"
echo ""
echo "🔧 Configuration:"
echo "  - Using official n8n task-runners.json format"
echo "  - N8N_RUNNERS_STDLIB_ALLOW: json,collections,time,datetime,io,base64"  
echo "  - N8N_RUNNERS_EXTERNAL_ALLOW: requests,pandas,matplotlib,numpy"
echo "  - Custom packages installed in task runner virtual environment"