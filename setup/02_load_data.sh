#!/usr/bin/env bash
# Creates the 3 raw tables and loads the CSVs from data/. Run once, from the project root.
set -euo pipefail
for t in raw_customers raw_orders raw_payments; do
  docker cp "data/${t}.csv" "hevo-pg:/tmp/${t}.csv"
done
docker exec -i hevo-pg psql -U postgres -d jaffle_shop -v ON_ERROR_STOP=1 < setup/sql/create_and_load_tables.sql
