{{
  config(
    materialized='table'
  )
}}

with orders as (
    select
      order_id,
      user_id,
      promo_id,
      address_id,
      created_at_utc,
      order_cost_usd,
      shipping_cost_usd,
      order_total_usd,
      tracking_id,
      shipping_service,
      estimated_delivery_at_utc,
      delivered_at_utc,
      status
    from {{ ref('stg_orders') }}
)

select *
from orders
