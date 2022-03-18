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
      order_cost,
      shipping_cost,
      order_total,
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
  promo_discount,
  promo_status
from orders
left join order_items
    on orders.order_id = order_items.order_id
left join promos
    on orders.promo_id = promos.promo_id
