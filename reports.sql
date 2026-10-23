-- 1. Monthly revenue with month-over-month growth
WITH m AS (SELECT strftime('%Y-%m',order_date) month, ROUND(SUM(amount),2) revenue FROM orders WHERE status='complete' GROUP BY 1)
SELECT month, revenue, ROUND(100.0*(revenue-LAG(revenue) OVER (ORDER BY month))/LAG(revenue) OVER (ORDER BY month),1) AS mom_pct FROM m ORDER BY month;
-- 2. Top 10 customers by lifetime value
SELECT c.name, c.region, COUNT(*) orders, ROUND(SUM(o.amount),2) ltv FROM orders o JOIN customers c ON c.id=o.customer_id WHERE o.status='complete' GROUP BY c.id ORDER BY ltv DESC LIMIT 10;
-- 3. Revenue by region with share of total
SELECT c.region, ROUND(SUM(o.amount),2) revenue, ROUND(100.0*SUM(o.amount)/SUM(SUM(o.amount)) OVER (),1) share_pct FROM orders o JOIN customers c ON c.id=o.customer_id WHERE o.status='complete' GROUP BY 1 ORDER BY 2 DESC;
-- 4. Refund rate by region
SELECT c.region, ROUND(100.0*AVG(o.status='refunded'),1) refund_pct FROM orders o JOIN customers c ON c.id=o.customer_id GROUP BY 1 ORDER BY 2 DESC;
-- 5. Customers inactive for 90+ days (churn risk)
SELECT c.name, MAX(o.order_date) last_order FROM customers c JOIN orders o ON o.customer_id=c.id GROUP BY c.id HAVING MAX(o.order_date) < date((SELECT MAX(order_date) FROM orders),'-90 days') ORDER BY last_order;
