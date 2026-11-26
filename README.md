# Self-Hosted n8n

A Docker Compose setup for running n8n with external Python task runners and PostgreSQL databases.

## Quick Start

1. Create your local `.env` (it is git-ignored; never commit real values):
   ```bash
   cp .env.example .env
   chmod 600 .env
   ```

2. Fill in each value in `.env` with a different random secret:
   ```bash
   openssl rand -hex 32
   ```
   Existing installs: Postgres only reads the password when its data directory is first created.
   To change it later, run `ALTER USER ... WITH PASSWORD ...` inside the database, then update `.env`.

3. Start the services:
   ```bash
   docker-compose up -d
   ```

4. Access n8n at: https://n8n.gedac.org

## Services

- **n8n**: Main workflow automation platform
- **task-runners**: Custom Python runner with additional libraries
- **postgres**: Main n8n database
- **postgres_rag**: Dedicated database for RAG operations with pgvector
- **caddy**: Reverse proxy with SSL termination

## Features

- External Python task runners with custom libraries for secure code execution
- PostgreSQL with pgvector extension for AI/RAG workflows
- SSL termination via Caddy
- Production-ready configuration

## Custom Python Libraries

The task runners include these additional Python libraries:
- `requests` - HTTP client for API calls
- `pandas` - Data manipulation and analysis
- `matplotlib` - Plotting and visualization
- Built-in libraries: `json`, `collections`, `time`, `datetime`

### Managing Python Dependencies

To add more Python libraries:

1. Edit `requirements.txt` to add new packages
2. Rebuild the custom image: `./build-runners.sh`
3. Restart the services: `docker compose down && docker compose up -d`

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

### Updating n8n Version

When manually changing the n8n version in `docker-compose.yml`, run this command to force recreate only the n8n service:

```bash
docker compose up -d --no-deps --force-recreate n8n
```

This ensures the n8n container is rebuilt with the new version without affecting other services.