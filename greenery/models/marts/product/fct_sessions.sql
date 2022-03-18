{{
  config(
    materialized='table'
  )
}}

SELECT
    session_id,
    user_id,
    min(created_at) AS started_at,
    max(created_at) AS finished_at,
    (
    DATE_PART('day', max(created_at)::timestamp - min(created_at)::timestamp) * 24 + 
    DATE_PART('hour', max(created_at)::timestamp - min(created_at)::timestamp)
    ) * 60 +
    DATE_PART('minute', max(created_at)::timestamp - min(created_at)::timestamp)
    as session_duration_min
FROM {{ref('stg_events')}}
GROUP BY 1, 2