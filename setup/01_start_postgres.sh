#!/usr/bin/env bash
# Starts PostgreSQL 16 in Docker with logical replication switched on.
# Needs PG_SUPERUSER_PASSWORD in the environment. It is never stored in this repo.
set -euo pipefail
: "${PG_SUPERUSER_PASSWORD:?Set PG_SUPERUSER_PASSWORD first}"

if docker ps -a --format '{{.Names}}' | grep -qx hevo-pg; then
  echo "Container hevo-pg already exists. Nothing to do."
  exit 0
fi

docker run -d --name hevo-pg \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD="$PG_SUPERUSER_PASSWORD" \
  -e POSTGRES_DB=jaffle_shop \
  -p 5432:5432 \
  -v hevo_pgdata:/var/lib/postgresql/data \
  --restart unless-stopped \
  postgres:16 \
  -c wal_level=logical \
  -c max_replication_slots=10 \
  -c max_wal_senders=10 \
  -c wal_sender_timeout=0

echo "Waiting for PostgreSQL to accept connections..."
until docker exec hevo-pg pg_isready -h 127.0.0.1 -U postgres -d jaffle_shop >/dev/null 2>&1; do
  sleep 2
done
docker exec hevo-pg psql -U postgres -d jaffle_shop -c "SHOW wal_level;"
echo "PostgreSQL is ready."
