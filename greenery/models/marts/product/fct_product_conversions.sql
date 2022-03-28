
with sessions as(
    select
        product_id,
        count(distinct session_id) as tot_sessions
    from {{ref('stg_events')}}
    {{ dbt_utils.group_by(1) }}
),
purchases as(
    select
        b.product_id,
        count(distinct session_id) as tot_purchases_sessions
    from {{ref('stg_events')}} a
    inner join {{ref('stg_order_items')}} b
        on a.order_id = b.order_id
    {{ dbt_utils.group_by(1) }}
)
select
    a.product_id,
    c.product_name,
    tot_sessions,
    tot_purchases_sessions
from sessions a
left join purchases b
    on a.product_id = b.product_id
inner join {{ref(('stg_products'))}} c
    on a.product_id = c.product_id

