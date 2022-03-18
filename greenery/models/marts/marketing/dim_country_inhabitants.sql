{{
  config(
    materialized='table'
  )
}}

with country_inhabitants as (
    select
        address.country,
        address.state,
        count(*) as country_inhabitants
    from {{ ref('stg_addresses') }} as address
        right join {{ ref('stg_users') }} as u
        on address.address_id = u.address_id
    group by
        1,2
)

select *
from country_inhabitants