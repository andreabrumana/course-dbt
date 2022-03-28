{{
  config(
    materialized='table'
  )
}}

with promos as (
    select * from {{ ref('stg_promos') }} 
)

,order_items as (
    select
        order_id,
        count(distinct product_id) as count_unique_products,
        sum(product_quantity) as order_quantity
    from {{ ref('stg_order_items') }} 
    group by 1
),

orders as (
    select
      order_id,
      user_id,
      promo_id,
      address_id,
      created_at,
      round(order_cost::numeric,2) as order_cost_usd,
      round(shipping_cost::numeric,2) as shipping_cost_usd,
      round(order_total::numeric,2) as order_total_usd,
      tracking_id,
      shipping_service,
      estimated_delivery_at,
      delivered_at,
      status,
      delivered_at-created_at as delivery_time,
      delivered_at <= estimated_delivery_at as on_time
    from {{ ref('stg_orders') }}
)

select
  orders.*,
  count_unique_products,
  order_quantity,
  coalesce(promo_discount,0) as promo_discount_usd,
  promo_status
from orders
left join order_items
    on orders.order_id = order_items.order_id
left join promos
    on orders.promo_id = promos.promo_id
