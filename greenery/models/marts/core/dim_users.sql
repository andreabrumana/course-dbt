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
      created_at,
      updated_at,
      b.address_id,
      address,
      zipcode,
      state,
      country
    from {{ ref('stg_users') }} a
    join {{ ref('stg_addresses')}} b
      on a.address_id = b.address_id
)

select *
from users