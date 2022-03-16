{{
  config(
    materialized='view'
  )
}}

with promos as (
    select
      promo_id,
      discount as discount_percentage,
      status as promo_status
    from {{ source('greenery', 'promos') }}
)

select *
from promos

