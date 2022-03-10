{{
  config(
    materialized='view'
  )
}}

with products as (
    select
      product_id,
      name,
      price,
      inventory
    from {{ source('greenery', 'products') }}
)

select *
from products

