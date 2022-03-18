{{
  config(
    materialized='table'
  )
}}

select
    a.user_id,
    a.full_name,
    a.email,
    a.phone_number,
    a.created_at,
    a.updated_at,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    now()-a.created_at as user_tenure,
    count(distinct c.order_id) as total_orders,
    sum(case when c.on_time is true then 1 end)*1.0
    /
    count(*)*1.0 as on_time_orders_ratio,
  --  avg(b.order_count) as avg_monthly_orders,
    avg(c.delivery_time) as avg_delivery_time
from {{ ref('dim_users') }} a 
--join {{ ref('int_monthly_orders')}} b
--    on a.user_id = b.user_id
join {{ ref('fct_orders')}} c 
    on a.user_id = c.user_id
group by
    1,2,3,4,5,6,7,8,9,10,11
