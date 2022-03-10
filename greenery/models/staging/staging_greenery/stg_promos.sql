{{
  config(
    materialized='view'
  )
}}

with promos as (
    select
      promo_id,
      discount,
      status
    from {{ source('greenery', 'promos') }}
)

select *
from promos

