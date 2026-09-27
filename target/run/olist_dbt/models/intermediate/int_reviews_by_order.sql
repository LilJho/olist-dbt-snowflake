
  create or replace   view ECOMM_DB.DBT_DEV.int_reviews_by_order
  
   as (
    SELECT
    order_id,
    SUM(review_score) AS total_review_score,
    COUNT(review_id) AS total_review_count
FROM ECOMM_DB.DBT_DEV.stg_order_reviews
GROUP BY order_id
  );

