#!/usr/bin/env bash
# The Docker image allows normal logins from any address but not replication connections.
# This adds one pg_hba.conf line for hevo_user and reloads the config.
# 0.0.0.0/0 is safe only because the cloud firewall lets in Hevo's IP addresses alone.
set -euo pipefail
HBA=/var/lib/postgresql/data/pg_hba.conf
LINE='host replication hevo_user 0.0.0.0/0 scram-sha-256'
docker exec hevo-pg bash -c "grep -qxF '$LINE' $HBA || echo '$LINE' >> $HBA"
docker exec hevo-pg psql -U postgres -c "SELECT pg_reload_conf();"
docker exec hevo-pg tail -n 3 "$HBA"
