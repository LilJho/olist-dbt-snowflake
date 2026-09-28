SELECT
    order_id,
    SUM(review_score) AS total_review_score,
    COUNT(review_id) AS total_review_count
FROM {{ ref('stg_order_reviews') }}
GROUP BY order_id