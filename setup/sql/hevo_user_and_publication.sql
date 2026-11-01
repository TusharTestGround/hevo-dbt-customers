-- Read-only user for Hevo, with the REPLICATION attribute that logical replication needs.
-- The password is set afterwards with \password (hidden input), so it is never stored in a file.
CREATE USER hevo_user WITH LOGIN;
ALTER ROLE hevo_user WITH REPLICATION;

GRANT CONNECT ON DATABASE jaffle_shop TO hevo_user;
GRANT USAGE ON SCHEMA public TO hevo_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO hevo_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO hevo_user;

-- Hevo reads changes through the pgoutput plugin and this publication.
CREATE PUBLICATION hevo_publication
  FOR TABLE public.raw_customers, public.raw_orders, public.raw_payments;
