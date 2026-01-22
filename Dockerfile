FROM apache/superset:latest

# Install system dependencies for MySQL and PostgreSQL clients
RUN apt-get update && apt-get install -y \
    pkg-config \
    libmariadb-dev \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages into Superset's virtual environment (this is the key fix!)
RUN /app/.venv/bin/pip install mysqlclient psycopg2-binary

COPY /config/superset_init.sh ./superset_init.sh
RUN chmod +x ./superset_init.sh
COPY /config/superset_config.py /app/
