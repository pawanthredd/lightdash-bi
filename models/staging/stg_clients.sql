SELECT 
    client_id,
    client_name,
    country,
    signup_date,
    annual_income
FROM {{ source('raw', 'clients') }}