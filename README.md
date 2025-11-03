# Self-Hosted n8n

A Docker Compose setup for running n8n with external Python task runners and PostgreSQL databases.

## Quick Start

1. Generate a secure auth token:
   ```bash
   openssl rand -hex 32
   ```

2. Update the auth token in `docker-compose.yml`:
   - Replace `your-secure-auth-token-here` in both n8n and task-runners services

3. Start the services:
   ```bash
   docker-compose up -d
   ```

4. Access n8n at: https://n8n.gedac.org

## Services

- **n8n**: Main workflow automation platform
- **task-runners**: External Python code execution environment
- **postgres**: Main n8n database
- **postgres_rag**: Dedicated database for RAG operations with pgvector
- **caddy**: Reverse proxy with SSL termination

## Features

- External Python task runners for secure code execution
- PostgreSQL with pgvector extension for AI/RAG workflows
- SSL termination via Caddy
- Production-ready configuration

## Management

```bash
# View logs
docker-compose logs -f [service-name]

# Restart services
docker-compose restart

# Stop all services
docker-compose down

# Update containers
docker-compose pull && docker-compose up -d
```