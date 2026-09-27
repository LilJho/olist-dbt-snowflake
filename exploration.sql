SELECT * FROM ECOMM_DB.DBT_DEV.STG_ORDERS
SELECT * FROM ECOMM_DB.DBT_DEV.STG_ORDER_ITEMS
SELECT * FROM ECOMM_DB.DBT_DEV.STG_ORDER_REVIEWS


SHOW VIEWS IN SCHEMA ECOMM_DB.DBT_DEV;

SELECT "order_item_id", COUNT(*) FROM ECOMM_DB.RAW.OLIST_ORDER_ITEMS GROUP BY 1 ORDER BY 1;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "review_id") AS unique_review_ids,
    COUNT(DISTINCT "order_id") AS unique_order_ids,
    COUNT(DISTINCT "review_id", "order_id") AS unique_combinations
FROM ECOMM_DB.RAW.OLIST_ORDER_REVIEWS;

SELECT *
FROM ECOMM_DB.RAW.OLIST_ORDER_REVIEWS
WHERE "review_id" IN (
    SELECT "review_id"
    FROM ECOMM_DB.RAW.OLIST_ORDER_REVIEWS
    GROUP BY 1
    HAVING COUNT(*) > 1
)
ORDER BY "review_id"

SELECT * FROM ECOMM_DB.DBT_DEV.INT_REVIEWS_BY_ORDER

WITH SellerOrders AS (
    SELECT
        seller_id,
        order_id,
        SUM(price) as order_revenue
    FROM ECOMM_DB.DBT_DEV.STG_ORDER_ITEMS
    GROUP BY seller_id, order_id
), Combined AS (
    SELECT
        so.seller_id,
        so.order_id,
        so.order_revenue,
        iro.total_review_score,
        iro.total_review_count
    FROM SellerOrders so
    LEFT JOIN ECOMM_DB.DBT_DEV.INT_REVIEWS_BY_ORDER iro ON so.order_id = iro.order_id
)
SELECT
    seller_id,
    COUNT(order_id) AS total_orders,
    SUM(order_revenue) AS total_price,
    COALESCE(SUM(total_review_score), 0) AS total_review_score,
    COALESCE(SUM(total_review_count), 0) AS total_review_count,
    ROUND(SUM(total_review_score) / NULLIF(SUM(total_review_count), 0), 2) AS avg_review_score
FROM Combined
GROUP BY seller_id

SELECT * FROM ECOMM_DB.DBT_DEV.FCT_SELLER_PERFORMANCE