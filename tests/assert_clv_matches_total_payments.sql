-- Total lifetime value across customers must equal total payments.
-- Catches double counting and payments lost in joins.
select 1
from (select sum(customer_lifetime_value) as clv from {{ ref('customers') }}) c
cross join (select sum(amount) as paid from {{ ref('stg_payments') }}) p
where c.clv <> p.paid
