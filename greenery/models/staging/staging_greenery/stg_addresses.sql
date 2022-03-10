{{
  config(
    materialized='view'
  )
}}

with addresses as (
    select
      address_id,
      address,
      zipcode,
      state,
      country
    from {{ source('greenery', 'addresses') }}
)

select *
from addresses