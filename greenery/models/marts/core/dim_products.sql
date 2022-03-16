{{
  config(
    materialized='table'
  )
}}

with products as (
    select
      product_id,
      product_name,
      price_usd,
      product_inventory
    from {{ ref('stg_products') }}
)

select *
from products
