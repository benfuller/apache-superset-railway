FROM apache/superset:latest

# Switch to root to install system packages
USER root

# Install system dependencies for MySQL and PostgreSQL clients
RUN apt-get update && apt-get install -y \
    pkg-config \
    libmariadb-dev \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Switch back to superset user
USER superset

# Install Python packages into Superset's virtual environment
RUN /app/.venv/bin/pip install mysqlclient psycopg2-binary

COPY /config/superset_init.sh ./superset_init.sh

# Switch to root again to chmod, then back to superset
USER root
RUN chmod +x ./superset_init.sh
USER superset

COPY /config/superset_config.py /app/
