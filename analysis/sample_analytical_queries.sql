/* =========================================================
   SAMPLE ANALYTICAL QUERIES
   Retail Data Warehouse – IICS
   ========================================================= */

------------------------------------------------------------
-- 1. Daily Sales Trend
------------------------------------------------------------
-- Shows total sales per day
SELECT 
    d.full_date,
    SUM(f.total_amount) AS daily_sales
FROM fact.fact_orders f
JOIN dw.dim_date d
    ON f.order_date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;


------------------------------------------------------------
-- 2. Monthly Sales Summary
------------------------------------------------------------
-- Helps business track monthly performance
SELECT 
    d.yr,
    d.mon,
    SUM(f.total_amount) AS monthly_sales
FROM fact.fact_orders f
JOIN dw.dim_date d
    ON f.order_date_key = d.date_key
GROUP BY d.yr, d.mon
ORDER BY d.yr, d.mon;


------------------------------------------------------------
-- 3. Top 10 Products by Revenue
------------------------------------------------------------
-- Identifies best-selling products
SELECT TOP 10
    p.product_name,
    SUM(i.line_total) AS total_revenue
FROM fact.fact_order_items i
JOIN dw.dim_product p
    ON i.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


------------------------------------------------------------
-- 4. Store Performance Analysis
------------------------------------------------------------
-- Compares sales across stores
SELECT
    s.store_name,
    s.city,
    SUM(f.total_amount) AS store_sales
FROM fact.fact_orders f
JOIN dw.dim_store s
    ON f.store_key = s.store_key
GROUP BY s.store_name, s.city
ORDER BY store_sales DESC;


------------------------------------------------------------
-- 5. Customer Lifetime Value
------------------------------------------------------------
-- Total amount spent by each customer
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(f.total_amount) AS lifetime_value
FROM fact.fact_orders f
JOIN dw.dim_customer c
    ON f.customer_key = c.customer_key
WHERE c.current_flag = 1
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lifetime_value DESC;


------------------------------------------------------------
-- 6. Repeat Customers
------------------------------------------------------------
-- Customers with more than one order
SELECT
    c.customer_id,
    COUNT(f.order_id) AS order_count
FROM fact.fact_orders f
JOIN dw.dim_customer c
    ON f.customer_key = c.customer_key
WHERE c.current_flag = 1
GROUP BY c.customer_id
HAVING COUNT(f.order_id) > 1
ORDER BY order_count DESC;


------------------------------------------------------------
-- 7. Average Order Value (AOV)
------------------------------------------------------------
-- Key retail KPI
SELECT
    AVG(total_amount) AS avg_order_value
FROM fact.fact_orders;


------------------------------------------------------------
-- 8. Payment Method Distribution
------------------------------------------------------------
-- Helps finance & ops teams
SELECT
    payment_method,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_amount
FROM fact.fact_orders
GROUP BY payment_method
ORDER BY total_amount DESC;


------------------------------------------------------------
-- 9. Product Category Performance
------------------------------------------------------------
-- Revenue by category
SELECT
    p.category,
    SUM(i.line_total) AS category_revenue
FROM fact.fact_order_items i
JOIN dw.dim_product p
    ON i.product_key = p.product_key
GROUP BY p.category
ORDER BY category_revenue DESC;


------------------------------------------------------------
-- 10. Sales by Store and Day
------------------------------------------------------------
-- Useful for operations planning
SELECT
    s.store_name,
    d.full_date,
    SUM(f.total_amount) AS daily_store_sales
FROM fact.fact_orders f
JOIN dw.dim_store s
    ON f.store_key = s.store_key
JOIN dw.dim_date d
    ON f.order_date_key = d.date_key
GROUP BY s.store_name, d.full_date
ORDER BY d.full_date, s.store_name;
