
  create or replace   view ECOMM_DB.DBT_DEV.stg_orders
  
   as (
    WITH source_olist AS (
    SELECT
        *
    FROM ECOMM_DB.RAW.OLIST_ORDERS
),
renamed AS (
    SELECT
        "order_id" AS order_id,
        "customer_id" AS customer_id,
        "order_status" AS order_status,
        "order_purchase_timestamp" AS order_purchase_at,
        "order_approved_at" AS order_approved_at,
        "order_delivered_carrier_date" AS order_delivered_carrier_at,
        "order_delivered_customer_date" AS order_delivered_customer_at,
        "order_estimated_delivery_date" AS order_estimated_delivery_at
    FROM source_olist
)
SELECT
    *
FROM renamed
  );

