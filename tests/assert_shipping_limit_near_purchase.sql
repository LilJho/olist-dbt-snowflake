{{ config(severity='warn') }}

SELECT
    i.order_id,
    i.order_item_seq,
    o.order_purchase_at,
    i.shipping_limit_at,
    DATEDIFF(day, o.order_purchase_at, i.shipping_limit_at) AS days_to_ship_limit
FROM {{ ref('stg_order_items') }} i
JOIN {{ ref('stg_orders') }} o
    ON i.order_id = o.order_id
WHERE DATEDIFF(day, o.order_purchase_at, i.shipping_limit_at) > 60
   OR i.shipping_limit_at < o.order_purchase_at