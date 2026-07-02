select
    card_id,
    product_id,
    cardholder_ref,
    card_type,
    issue_date,
    activation_date,
    expiry_date,
    card_status
from {{ source('landing_db', 'cards') }}