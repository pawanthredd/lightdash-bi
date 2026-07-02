{{
    config(
        tags=['bi']
    )
}}
select
    bin_sponsor_id,
    bin_sponsor_name,
    country_code,
    region,
    bin_range_start,
    bin_range_end,
    sponsor_tier,
    onboarded_date,
    status,
    risk_rating
from {{ source('landing_db', 'bin_sponsors') }}