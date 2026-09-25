
  create or replace   view ECOMM_DB.DBT_DEV.stg_order_reviews
  
   as (
    WITH source_olist AS (
    SELECT
        *
    FROM ECOMM_DB.RAW.OLIST_ORDER_REVIEWS
),
renamed AS (
    SELECT
        "review_id" AS review_id,
        "order_id" AS order_id,
        "review_score" AS review_score,
        "review_comment_title" AS review_comment_title,
        "review_comment_message" AS review_comment_message,
        "review_creation_date" AS review_creation_at,
        "review_answer_timestamp" AS review_answer_at
    FROM source_olist
)
SELECT
    *
FROM renamed
  );

