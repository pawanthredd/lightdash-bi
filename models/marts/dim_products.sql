select
    product_id,
    product_name,
    program_manager_id,
    product_type,
    card_network,
    form_factor,
    currency,
    launch_date,
    status,
    target_segment
from {{ source('landing_db', 'products') }}