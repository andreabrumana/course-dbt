{{
  config(
    materialized='view'
  )
}}

with orders as (
    select
      order_id,
      user_id,
      created_at
    from {{ ref('stg_orders') }}
)

select 
    to_char(created_at,'YYYY-MM') as month_year_desc,
    user_id,
    count (DISTINCT order_id) as order_count
from orders
group by 
    1,2