{{
  config(
    materialized='table'
  )
}}

SELECT
    event_id AS page_view_id,
    page_url,
    session_id,
    user_id,
    created_at AS viewed_at
FROM {{ref('stg_events')}}
WHERE event_type = 'page_view'
