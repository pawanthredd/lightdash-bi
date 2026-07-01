SELECT
    bank_id,
    bank_name,
    sponsor_name,
    country,
    status
FROM {{ ref('stg__banks') }}