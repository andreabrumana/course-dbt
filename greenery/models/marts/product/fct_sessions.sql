{{
  config(
    materialized='table'
  )
}}

SELECT
    session_id,
    user_id,
    product_id,
    min(created_at) AS session_start_time,
    max(created_at) AS session_finish_time,
    (
    DATE_PART('day', max(created_at)::timestamp - min(created_at)::timestamp) * 24 + 
    DATE_PART('hour', max(created_at)::timestamp - min(created_at)::timestamp)
    ) * 60 +
    DATE_PART('minute', max(created_at)::timestamp - min(created_at)::timestamp)
    as session_duration_min,
    {{ agg_by_col('events', 'event_type') }}
FROM {{ref('stg_events')}}
{{ dbt_utils.group_by(3) }}