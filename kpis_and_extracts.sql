-- KPI: Monthly GMV & Orders
SELECT
  DATE_TRUNC('month', o.order_date) AS month,
  COUNT(DISTINCT o.order_id) AS orders,
  SUM(oi.quantity * oi.unit_price * (1 - oi.discount_rate)) AS gmv
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;

-- KPI: Category performance
SELECT
  p.category,
  COUNT(DISTINCT o.order_id) AS orders,
  SUM(oi.quantity) AS units,
  ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_rate)), 2) AS gmv
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY gmv DESC;

-- RFM snapshot
WITH rfm AS (
  SELECT
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS frequency,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount_rate)) AS monetary,
    MAX(o.order_date) AS last_order
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  GROUP BY 1
)
SELECT
  c.customer_id,
  c.region,
  c.channel,
  c.segment,
  COALESCE(rfm.frequency, 0) AS frequency,
  COALESCE(rfm.monetary, 0) AS monetary,
  EXTRACT(EPOCH FROM (NOW() - COALESCE(rfm.last_order, c.signup_date)))/86400 AS recency_days,
  c.churned
FROM customers c
LEFT JOIN rfm ON c.customer_id = rfm.customer_id;

-- Churn rate by segment/region
SELECT segment, region,
  AVG(churned)::numeric(5,3) AS churn_rate
FROM customers
GROUP BY 1,2
ORDER BY churn_rate DESC;