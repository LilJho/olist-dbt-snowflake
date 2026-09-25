WITH source_olist AS (
    SELECT
        *
    FROM ECOMM_DB.RAW.OLIST_ORDER_ITEMS
),
renamed AS (
    SELECT
        "order_id" AS order_id,
        "order_item_id" AS order_item_seq,
        "product_id" AS product_id,
        "seller_id" AS seller_id,
        "shipping_limit_date" AS shipping_limit_at,
        "price" AS price,
        "freight_value" AS freight_value
    FROM source_olist
)
SELECT
    *
FROM renamed