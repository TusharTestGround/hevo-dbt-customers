select
    id          as order_id,
    user_id     as customer_id,
    order_date,
    status
from {{ source('hevo_raw', 'raw_orders') }}
{% if var('hevo_deleted_flag') != 'none' %}
where coalesce({{ var('hevo_deleted_flag') }}, false) = false
{% endif %}
