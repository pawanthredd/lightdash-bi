SELECT 
    authorisation_id,
    card_id,
    auth_amount,
    merchant_name,
    auth_timestamp,
    auth_status
FROM {{ source('raw', 'authorisations') }}