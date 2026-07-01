SELECT
    bin_sponsor_id,
    sponsor_name,
    sponsor_code,
    headquarters_country,
    region,
    risk_tier,
    onboarding_date,
    annual_fee,
    active_flag,
    created_at
FROM {{ source('raw', 'bin_sponsor') }}