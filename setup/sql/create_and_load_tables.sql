-- Raw tables, loaded as-is from the CSVs. Primary keys are required for logical replication.
CREATE TABLE public.raw_customers (
  id          INTEGER PRIMARY KEY,
  first_name  VARCHAR(100),
  last_name   VARCHAR(100)
);

CREATE TABLE public.raw_orders (
  id          INTEGER PRIMARY KEY,
  user_id     INTEGER,
  order_date  DATE,
  status      VARCHAR(50)
);

CREATE TABLE public.raw_payments (
  id              INTEGER PRIMARY KEY,
  order_id        INTEGER,
  payment_method  VARCHAR(50),
  amount          INTEGER
);

COPY public.raw_customers FROM '/tmp/raw_customers.csv' WITH (FORMAT csv, HEADER true);
COPY public.raw_orders    FROM '/tmp/raw_orders.csv'    WITH (FORMAT csv, HEADER true);
COPY public.raw_payments  FROM '/tmp/raw_payments.csv'  WITH (FORMAT csv, HEADER true);

SELECT 'raw_customers' AS table_name, count(*) AS row_count FROM public.raw_customers
UNION ALL SELECT 'raw_orders', count(*) FROM public.raw_orders
UNION ALL SELECT 'raw_payments', count(*) FROM public.raw_payments;
