{{ config(severity='error') }}

SELECT
COALESCE(fspi.seller_id, fsp.seller_id) AS seller_id,
fspi.total_orders AS inc_total_orders, fsp.total_orders AS fullb_total_orders,
fspi.total_revenue AS inc_total_revenue, fsp.total_revenue AS fullb_total_revenue,
fspi.total_review_count AS inc_total_review_count, fsp.total_review_count AS fullb_total_review_count,
fspi.total_review_score AS inc_total_review_score, fsp.total_review_score AS fullb_total_review_score
FROM {{ ref('fct_seller_performance_incremental') }} fspi
FULL JOIN {{ ref('fct_seller_performance') }} fsp
    ON fspi.seller_id = fsp.seller_id
WHERE fspi.total_orders IS DISTINCT FROM fsp.total_orders
    OR fspi.total_revenue IS DISTINCT FROM fsp.total_revenue
    OR fspi.total_review_count IS DISTINCT FROM fsp.total_review_count
    OR fspi.total_review_score IS DISTINCT FROM fsp.total_review_score