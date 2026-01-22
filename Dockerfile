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

# Switch back to superset user to install Python packages
USER superset

# Install Python packages into Superset's virtual environment
RUN pip install mysqlclient psycopg2-binary

# Copy init script (as superset user first, then chmod as root)
COPY --chown=superset:superset /config/superset_init.sh ./superset_init.sh
COPY --chown=superset:superset /config/superset_config.py /app/

# Switch to root just to chmod, then back
USER root
RUN chmod +x /app/superset_init.sh
USER superset
