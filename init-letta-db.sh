#!/bin/bash
set -e

# Set permissions for PostgreSQL data directory
if [ -d "/var/lib/postgresql/data" ]; then
  chown -R postgres:postgres /var/lib/postgresql/data
  chmod -R 700 /var/lib/postgresql/data
fi

# Copy init.sql if it doesn’t exist
if [ ! -f "/docker-entrypoint-initdb.d/init.sql" ]; then
  echo "Using default init.sql for database initialization."
  cp /default-scripts/init.sql /docker-entrypoint-initdb.d/init.sql
fi

# Run PostgreSQL with the postgres user
exec gosu postgres postgres "$@"
