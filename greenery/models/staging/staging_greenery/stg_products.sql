{{
  config(
    materialized='view'
  )
}}

with products as (
    select
      product_id,
      name as product_name,
      price,
      inventory as product_inventory
    from {{ source('greenery', 'products') }}
)

select *
from products

