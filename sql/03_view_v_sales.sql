USE DATABASE RETAIL_SALES;
USE SCHEMA STAGING;

CREATE OR REPLACE VIEW V_SALES AS
SELECT
  f.sales_sk, f.order_id, f.order_date, f.ship_date, f.ship_mode,
  d.year, d.quarter, d.month, d.month_name, d.is_weekend,
  f.quantity, f.discount, f.sales, f.profit,
  dc.customer_sk, dc.customer_id, dc.customer_name, dc.segment,
  dp.product_sk, dp.product_id, dp.category, dp.sub_category, dp.product_name,
  dr.region_sk, dr.country, dr.state, dr.city, dr.postal_code, dr.region,
  DATEDIFF('day', f.order_date, f.ship_date) AS delivery_days
FROM FACT_SALES f
JOIN DIM_DATE     d  ON f.date_id     = d.date_id
JOIN DIM_CUSTOMER dc ON f.customer_sk = dc.customer_sk
JOIN DIM_PRODUCT  dp ON f.product_sk  = dp.product_sk
JOIN DIM_REGION   dr ON f.region_sk   = dr.region_sk;
