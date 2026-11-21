-- Monthly KPIs
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(*) AS orders,
       ROUND(SUM(order_value) / 100000, 2) AS revenue_lakh,
       ROUND(AVG(delivery_min), 1) AS avg_delivery_min,
       ROUND(AVG(rating), 2) AS avg_rating
FROM orders
WHERE status = 'Delivered'
GROUP BY month
ORDER BY month;

-- Kitchen ranking by share of slow deliveries (> 35 min)
SELECT kitchen,
       COUNT(*) AS orders,
       ROUND(100 * AVG(delivery_min > 35), 1) AS pct_slow,
       ROUND(AVG(rating), 2) AS avg_rating
FROM orders
WHERE status = 'Delivered'
GROUP BY kitchen
ORDER BY pct_slow DESC;
