#!/usr/bin/env bash
# Creates the Hevo user, grants and publication, then asks for the user's password.
set -euo pipefail
docker exec -i hevo-pg psql -U postgres -d jaffle_shop -v ON_ERROR_STOP=1 < setup/sql/hevo_user_and_publication.sql
echo "Set the hevo_user password now. Type it twice; nothing shows while you type."
docker exec -it hevo-pg psql -U postgres -d jaffle_shop -c '\password hevo_user'
