SELECT 
    transaction_id,
    authorisation_id,
    card_id,
    transaction_amount,
    transaction_timestamp,
    transaction_status
FROM {{ ref('stg_transactions') }}