# WEEK 1 - SHORT ANSWERS

### 1 - How many users do we have?
Answer: **130**

Query:
``` sql
select 
  count(distinct user_id)
from dbt_andrea_b.stg_users
```

### 2 - On average, how many orders do we receive per hour?
Answer: **7.52**

Query:
``` sql
with order_per_hour as
(
select
  date_trunc('hour', created_at) as created_hour
  ,count (distinct order_id) as orders_number
from dbt_andrea_b.stg_orders
group by 1
)
select avg(orders_number) from order_per_hour
```

## 3 - On average, how long does an order take from being placed to being delivered?
Answer: **3 days, 21 hours and 24 minutes (~ 94h)**

Query:
``` sql
select 
  avg(delivered_at-created_at) 
from dbt_andrea_b.stg_orders 
where status = 'delivered'
```

### 4 - How many users have only made one purchase? Two purchases? Three+ purchases?
Answer:
| # purchases | # users |
|-------------|---------|
|            1|       25|
|            2|       28|
|           3+|       71|

Query:
``` sql
with orders_by_user as
(
  select
    user_id,
    count(distinct order_id) as order_number
  from dbt_andrea_b.stg_orders
  group by 1
)
select
  case 
    when order_number >= 3 then '3+'
    else order_number::varchar
  end as order_number,
  count(distinct user_id)
from orders_by_user
group by 1
```

### 5 - On average, how many unique sessions do we have per hour?
Answer: **7.33**

Query:
``` sql
with sessions_per_hour as
(
  select
    date_trunc('hour', created_at) as created_hour
    ,count (distinct session_id) as sessions_number
  from dbt_andrea_b.stg_events
  group by 1
)
select
  avg(sessions_number)
from sessions_per_hour
```
