FROM apache/superset:latest

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libmariadb-dev \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages into the venv using its Python interpreter
RUN /app/.venv/bin/python -m pip install mysqlclient psycopg2-binary

# Copy config files
COPY /config/superset_init.sh /app/superset_init.sh
COPY /config/superset_config.py /app/
RUN chmod +x /app/superset_init.sh

USER superset
