-- A customer's first order can never be later than their most recent order.
select *
from {{ ref('customers') }}
where first_order > most_recent_order
