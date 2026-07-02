select
    program_manager_id,
    program_manager_name,
    bin_sponsor_id,
    industry_vertical,
    country_code,
    onboarded_date,
    status,
    fee_tier
from {{ source('landing_db', 'program_managers') }}