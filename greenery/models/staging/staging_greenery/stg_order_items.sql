{{
  config(
    materialized='view'
  )
}}

with order_items as (
    select
        order_id,
        product_id,
        quantity
    from {{ source('greenery', 'order_items') }}
)

select *
from order_items
