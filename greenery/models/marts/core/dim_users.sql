{{
  config(
    materialized='table'
  )
}}

with users as (
    select
      user_id,
      first_name,
      last_name,
      first_name || last_name as full_name,
      email,
      phone_number,
      created_at_utc,
      updated_at_utc,
      address_id
    from {{ ref('stg_users') }}
)

select *
from users