SELECT
    program_manager_id,
    bin_sponsor_id,
    program_name,
    industry,
    country,
    launch_date,
    active_customers,
    monthly_growth_rate,
    kyc_provider,
    status,
    created_at
FROM {{ ref('stg__program_manager') }}