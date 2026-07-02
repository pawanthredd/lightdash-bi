SELECT
    product_id,
    program_manager_id,
    product_name,
    product_type,
    card_network,
    card_type,
    currency,
    country,
    monthly_fee,
    interchange_rate,
    launch_date,
    status,
    created_at
FROM {{ ref('stg__products') }}