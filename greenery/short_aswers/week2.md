# (Part 1) Models 
---

## 1 - What is our user repeat rate?
Answer: 79.9%

Query on staging tables:
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
Query on fact/dimension tables:
```sql
select 
sum(case when total_orders>=2 then 1 end)*1.0 
/ count(*)*1.0 as repeat_rate
from dbt_andrea_b.fct_users_orders;
```
## 2 - What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators of a user who will likely purchase again are:
- *higher* frequency of purchase
- *higher* events generated on Greenery website
- *higher* number of orders 
- *higher* quantity per order
- *higher* conversion rate (#add_to_cart/#page_views)
- *lower* tot_delivery_time (delivered_at-created_at)
- *lower* time since last event generated
- *higher* % on time deliveries (% of deliveries that is delivered on time)


Good indicators of a user who will likely purchase again are:
- *lower* frequency of purchase
- *lower* events generated on Greenery website
- *lower* number of orders 
- *lower* quantity per order
- *lower* conversion rate (#add_to_cart/#page_views)
- *higher* tot_delivery_time (delivered_at-created_at)
- *higher* time since last event generated
- *lower* % on time deliveries (% of deliveries that is delivered on time)


If I had more data, I would like to have information about:
- #reviews provided on products (stars, likes, etc.)
- time spent on the platform
- #customer Service contacts
- Metrics on customer satisfaction, such as a feedback about the delivery, the products or the company (NPS, i.e. Net Promoter Score)
- #referrals sent

## 3 - Explain the marts models you added. Why did you organize the models in the way you did?
### Core
- `dim_products`: dimensional model of products
- `dim_users`: dimensional model of users
- `fct_orders`: fact model of orders
### Marketing
- **intermediate**
    - `int_monthly_orders`: intermediate model that has the count of monhtly order by users
- `dim_country_users`: a table that shows the number of users by country/state
- `fct_users_orders`: this table stores different order metrics at user level that relates with CX
### Product
- `fct_page_views`: this table contains information about page views
- `fct_sessions`: this table contains information about sessions duration

---
# (Part 2) Tests 
---
## 1 - What assumptions are you making about each model? (i.e. why are you adding each test?)
In staging models, I tested 
- uniqueness and existence (not_null) of primary keys
- positivy for numeric values
- existence for created_at (when available)
- positivity, for price, quantity, etc.


## 2 - Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
I did not found bad data importing from sources.

## 3 - Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
To perform daily tests on data, I'd recommend schedule the dbt run followed by dbt test (or only the dbt build command, to run both at once) every day. That way the models are created/refreshed on a daily base, and also tests are applied. If a test fails, dbt shows the failure. Also, it can be set up an automatic way to store/notify the output of the tests, so in case of failure the responsible is notified.
