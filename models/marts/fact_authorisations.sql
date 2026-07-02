select
    authorisation_id,
    card_id,
    product_id,
    authorisation_datetime,
    merchant_id,
    merchant_name,
    mcc_code,
    mcc_description,
    merchant_country,
    channel,
    pos_entry_mode,
    auth_amount,
    currency,
    auth_response_code,
    auth_status,
    decline_reason
from {{ source('landing_db', 'authorisations') }}