{{ config(
    materialized='incremental',
    unique_key=['order_id', 'seller_id'],
    incremental_strategy='merge'
) }}

SELECT
    i.order_id,
    i.seller_id,
    o.order_purchase_at,
    SUM(i.price) AS order_revenue,
    COUNT(*) AS item_count
FROM {{ ref('stg_order_items') }} i
JOIN {{ ref('stg_orders') }} o
    ON i.order_id = o.order_id

{% if is_incremental() %}
WHERE o.order_purchase_at >= (SELECT MAX(order_purchase_at) FROM {{ this }})
{% endif %}

GROUP BY i.order_id, i.seller_id, o.order_purchase_at