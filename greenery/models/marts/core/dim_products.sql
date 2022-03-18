{{
  config(
    materialized='table'
  )
}}

with products as (
    select
      product_id,
      product_name,
      price
    from {{ ref('stg_products') }}
)

select *
from products
