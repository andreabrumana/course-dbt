## What is our user repeat rate?
Answer: 79.4%

Query:
```sql
with orders_by_user as
(
  select
    user_id,
    count(distinct order_id) as order_number
  from dbt_andrea_b.stg_orders
  group by 1
)
select
  sum(case when order_number >= 2 then 1 end) * 1.0 
  / count(*) * 1.0 as repeat_rate
from orders_by_user
```

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
