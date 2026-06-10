SELECT 
    client_id,
    client_name,
    country,
    signup_date,
    annual_revenue
FROM {{ source('raw', 'clients') }}