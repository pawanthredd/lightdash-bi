select
    transaction_id,
    authorisation_id,
    card_id,
    product_id,
    transaction_datetime,
    settlement_date,
    transaction_type,
    merchant_id,
    mcc_code,
    transaction_amount,
    currency,
    interchange_amount,
    scheme_fee_amount,
    processor_fee_amount,
    net_settlement_amount,
    transaction_status
from {{ source('landing_db', 'transactions') }}