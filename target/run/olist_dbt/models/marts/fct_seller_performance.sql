
  
    

        create or replace transient table ECOMM_DB.DBT_DEV.fct_seller_performance
         as
        (WITH SellerOrders AS (
    SELECT
        seller_id,
        order_id,
        SUM(price) as order_revenue
    FROM ECOMM_DB.DBT_DEV.stg_order_items
    GROUP BY seller_id, order_id
), Combined AS (
    SELECT
        so.seller_id,
        so.order_id,
        so.order_revenue,
        iro.total_review_score,
        iro.total_review_count
    FROM SellerOrders so
    LEFT JOIN ECOMM_DB.DBT_DEV.int_reviews_by_order iro ON so.order_id = iro.order_id
)
SELECT
    seller_id,
    COUNT(order_id) AS total_orders,
    SUM(order_revenue) AS total_revenue,
    COALESCE(SUM(total_review_score), 0) AS total_review_score,
    COALESCE(SUM(total_review_count), 0) AS total_review_count,
    ROUND(SUM(total_review_score) / NULLIF(SUM(total_review_count), 0), 2) AS avg_review_score
FROM Combined
GROUP BY seller_id
        );
      
  