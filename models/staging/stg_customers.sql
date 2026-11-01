select
    id          as customer_id,
    first_name,
    last_name
from {{ source('hevo_raw', 'raw_customers') }}
{% if var('hevo_deleted_flag') != 'none' %}
where coalesce({{ var('hevo_deleted_flag') }}, false) = false
{% endif %}
