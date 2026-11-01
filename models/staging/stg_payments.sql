-- Amounts are order values in dollars, as given in the source. The data does not state a unit.
select
    id              as payment_id,
    order_id,
    payment_method,
    amount
from {{ source('hevo_raw', 'raw_payments') }}
{% if var('hevo_deleted_flag') != 'none' %}
where coalesce({{ var('hevo_deleted_flag') }}, false) = false
{% endif %}
