SELECT 
    card_id,
    client_id,
    card_type,
    card_status,
    issued_date
FROM {{ source('raw', 'cards') }}