--1 Row Count & File Load Check
-- Total rows loaded into staging
SELECT COUNT(*) AS total_rows
FROM stg.stg_customers;

-- Row count by source file
SELECT 
    file_name,
    COUNT(*) AS row_count
FROM stg.stg_customers
GROUP BY file_name;

--Confirms file ingestion completeness

--2 Business Key Validation (customer_id)
-- Check for NULL customer_id
SELECT *
FROM stg.stg_customers
WHERE customer_id IS NULL;

-- Check for duplicate customer_id in staging
SELECT 
    customer_id,
    COUNT(*) AS cnt
FROM stg.stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


--Ensures uniqueness before dimension load

--3 Mandatory Column NULL Checks
-- Mandatory business attributes should not be NULL
SELECT *
FROM stg.stg_customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL;


--Prevents incomplete dimension records

--4 Email Format Sanity Check
-- Basic email format validation
SELECT *
FROM stg.stg_customers
WHERE email NOT LIKE '%@%.%';


--Simple but realistic data quality rule

--5 Phone Number Validation
-- Phone should contain only digits and have reasonable length
SELECT *
FROM stg.stg_customers
WHERE phone IS NOT NULL
  AND (
        phone LIKE '%[^0-9]%' 
        OR LEN(phone) < 8
        OR LEN(phone) > 15
      );


--Flags invalid contact data

--6 Geographic Data Validation
-- State should be exactly 2 characters (India state code)
SELECT *
FROM stg.stg_customers
WHERE state IS NOT NULL
  AND LEN(state) <> 2;

-- City should not be numeric
SELECT *
FROM stg.stg_customers
WHERE city LIKE '%[0-9]%';

--7 Audit & Metadata Validation
-- Audit fields must be populated
SELECT *
FROM stg.stg_customers
WHERE insert_dt IS NULL
   OR batch_id IS NULL
   OR file_row_number IS NULL;

-- File row number should be positive
SELECT *
FROM stg.stg_customers
WHERE file_row_number <= 0;

--8 Duplicate Row Detection (Full Row)
-- Detect exact duplicate rows
SELECT 
    customer_id,
    first_name,
    last_name,
    email,
    COUNT(*) AS cnt
FROM stg.stg_customers
GROUP BY 
    customer_id,
    first_name,
    last_name,
    email
HAVING COUNT(*) > 1;


--Catches accidental file re-loads

--9 Load User Check (Optional but Professional)
-- Validate load user is populated
SELECT *
FROM stg.stg_customers
WHERE load_user IS NULL;


--1 Row Count & File Load Check
-- Total rows loaded
SELECT COUNT(*) AS total_rows
FROM stg.stg_products;

-- Row count by source file
SELECT 
    file_name,
    COUNT(*) AS row_count
FROM stg.stg_products
GROUP BY file_name;

--2 Business Key Validation (product_id)
-- product_id must not be NULL
SELECT *
FROM stg.stg_products
WHERE product_id IS NULL;

-- Duplicate product_id check
SELECT 
    product_id,
    COUNT(*) AS cnt
FROM stg.stg_products
GROUP BY product_id
HAVING COUNT(*) > 1;


--Critical before loading dimension

--3Mandatory Attribute Checks
-- Mandatory attributes should not be NULL
SELECT *
FROM stg.stg_products
WHERE product_name IS NULL
   OR category IS NULL
   OR brand IS NULL;

--4Unit Price Validation (VERY IMPORTANT)
-- Unit price should not be NULL
SELECT *
FROM stg.stg_products
WHERE unit_price IS NULL;

-- Unit price should be positive
SELECT *
FROM stg.stg_products
WHERE unit_price <= 0;

-- Unusually high prices (outlier check)
SELECT *
FROM stg.stg_products
WHERE unit_price > 100000;


--Prevents fact calculation errors

--5 Product Name Quality Checks
-- Product name should not be numeric
SELECT *
FROM stg.stg_products
WHERE product_name LIKE '%[0-9]%' 
  AND product_name NOT LIKE '% %';

-- Trim check (leading/trailing spaces)
SELECT *
FROM stg.stg_products
WHERE product_name <> LTRIM(RTRIM(product_name));

--6 Category & Brand Consistency
-- Category should not be numeric
SELECT *
FROM stg.stg_products
WHERE category LIKE '%[0-9]%';

-- Brand should not be numeric
SELECT *
FROM stg.stg_products
WHERE brand LIKE '%[0-9]%';

--7 Audit & Metadata Validation
-- Audit columns must be populated
SELECT *
FROM stg.stg_products
WHERE insert_dt IS NULL
   OR batch_id IS NULL
   OR file_row_number IS NULL;

-- File row number must be positive
SELECT *
FROM stg.stg_products
WHERE file_row_number <= 0;

--8 Duplicate Row Detection (Full Row)
-- Exact duplicate row check
SELECT 
    product_id,
    product_name,
    category,
    brand,
    unit_price,
    COUNT(*) AS cnt
FROM stg.stg_products
GROUP BY 
    product_id,
    product_name,
    category,
    brand,
    unit_price
HAVING COUNT(*) > 1;

--9 Load User Validation
-- load_user must be populated
SELECT *
FROM stg.stg_products
WHERE load_user IS NULL;



--1 Row Count & Load Check
-- Total rows loaded
SELECT COUNT(*) AS total_rows
FROM stg.stg_stores;

-- Row count by source file
SELECT 
    file_name,
    COUNT(*) AS row_count
FROM stg.stg_stores
GROUP BY file_name;

--2 Business Key Validation (store_id)
-- store_id must not be NULL
SELECT *
FROM stg.stg_stores
WHERE store_id IS NULL;

-- Duplicate store_id check
SELECT 
    store_id,
    COUNT(*) AS cnt
FROM stg.stg_stores
GROUP BY store_id
HAVING COUNT(*) > 1;

--3 Mandatory Attribute Checks
-- Mandatory store attributes
SELECT *
FROM stg.stg_stores
WHERE store_name IS NULL
   OR city IS NULL
   OR state IS NULL;

--4 Store Name Quality
-- Store name should not be numeric
SELECT *
FROM stg.stg_stores
WHERE store_name LIKE '%[0-9]%' 
  AND store_name NOT LIKE '% %';

-- Leading / trailing spaces
SELECT *
FROM stg.stg_stores
WHERE store_name <> LTRIM(RTRIM(store_name));

--5 City & State Validation
-- City should not be numeric
SELECT *
FROM stg.stg_stores
WHERE city LIKE '%[0-9]%';

-- State should not be numeric
SELECT *
FROM stg.stg_stores
WHERE state LIKE '%[0-9]%';

--6 Audit & Metadata Checks
-- Audit columns must be populated
SELECT *
FROM stg.stg_stores
WHERE insert_dt IS NULL
   OR batch_id IS NULL
   OR file_row_number IS NULL;

-- File row number must be positive
SELECT *
FROM stg.stg_stores
WHERE file_row_number <= 0;

--7 Duplicate Full Row Check
-- Exact duplicate rows
SELECT 
    store_id,
    store_name,
    city,
    state,
    COUNT(*) AS cnt
FROM stg.stg_stores
GROUP BY 
    store_id,
    store_name,
    city,
    state
HAVING COUNT(*) > 1;

--8 Load User Validation
-- load_user must be populated
SELECT *
FROM stg.stg_stores
WHERE load_user IS NULL;

--1 Row Count & File Load Check
-- Total rows loaded
SELECT COUNT(*) AS total_rows
FROM stg.stg_orders;

-- Rows per source file
SELECT 
    file_name,
    COUNT(*) AS row_count
FROM stg.stg_orders
GROUP BY file_name;

--2 Business Key Validation (order_id)
-- order_id must not be NULL
SELECT *
FROM stg.stg_orders
WHERE order_id IS NULL;

-- Duplicate order_id check
SELECT 
    order_id,
    COUNT(*) AS cnt
FROM stg.stg_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

--3 Order Date Validation
-- order_date must not be NULL
SELECT *
FROM stg.stg_orders
WHERE order_date IS NULL;

-- Order date should not be in future
SELECT *
FROM stg.stg_orders
WHERE order_date > CAST(GETDATE() AS DATE);

-- Invalid order_date values
SELECT *
FROM stg.stg_orders
WHERE TRY_CAST(order_date AS DATE) IS NULL;

--4 Foreign Key Presence Checks
-- customer_id must not be NULL
SELECT *
FROM stg.stg_orders
WHERE customer_id IS NULL;

-- store_id must not be NULL
SELECT *
FROM stg.stg_orders
WHERE store_id IS NULL;

--5 Total Amount Validation
-- total_amount must not be NULL
SELECT *
FROM stg.stg_orders
WHERE total_amount IS NULL;

-- total_amount should not be negative
SELECT *
FROM stg.stg_orders
WHERE total_amount < 0;

--6 Payment Method Validation
-- payment_method must not be NULL
SELECT *
FROM stg.stg_orders
WHERE payment_method IS NULL;

-- Unexpected payment methods
SELECT DISTINCT payment_method
FROM stg.stg_orders;


--7 Audit & Metadata Validation
-- Audit columns must be populated
SELECT *
FROM stg.stg_orders
WHERE batch_id IS NULL
   OR file_row_number IS NULL
   OR insert_dt IS NULL;

-- File row number must be positive
SELECT *
FROM stg.stg_orders
WHERE file_row_number <= 0;

--8 Duplicate Full Row Check
-- Exact duplicate order rows
SELECT 
    order_id,
    order_date,
    customer_id,
    store_id,
    total_amount,
    COUNT(*) AS cnt
FROM stg.stg_orders
GROUP BY 
    order_id,
    order_date,
    customer_id,
    store_id,
    total_amount
HAVING COUNT(*) > 1;

--9 Referential Integrity 
-- Orders with missing customer reference
SELECT o.*
FROM stg.stg_orders o
LEFT JOIN dw.dim_customer c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Orders with missing store reference
SELECT o.*
FROM stg.stg_orders o
LEFT JOIN dw.dim_store s
    ON o.store_id = s.store_id
WHERE s.store_id IS NULL;

--10 Load User Validation
-- load_user must be populated
SELECT *
FROM stg.stg_orders
WHERE load_user IS NULL;

--1 Row Count & File Load Validation
-- Total rows loaded
SELECT COUNT(*) AS total_rows
FROM stg.stg_order_items;

-- Rows per source file
SELECT 
    file_name,
    COUNT(*) AS row_count
FROM stg.stg_order_items
GROUP BY file_name;

--2 Business Key Validation
-- order_id must not be NULL
SELECT *
FROM stg.stg_order_items
WHERE order_id IS NULL;

-- order_item_id must not be NULL
SELECT *
FROM stg.stg_order_items
WHERE order_item_id IS NULL;

-- Duplicate order line check
SELECT 
    order_id,
    order_item_id,
    COUNT(*) AS cnt
FROM stg.stg_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

--3 Foreign Key Presence Checks
-- product_id must not be NULL
SELECT *
FROM stg.stg_order_items
WHERE product_id IS NULL;



--4 Quantity Validation
-- quantity must not be NULL
SELECT *
FROM stg.stg_order_items
WHERE quantity IS NULL;

-- quantity must be greater than zero
SELECT *
FROM stg.stg_order_items
WHERE quantity <= 0;


--5  Line Total Validation
-- line_total must not be NULL
SELECT *
FROM stg.stg_order_items
WHERE line_total IS NULL;



--6 Audit & Metadata Validation
-- Mandatory audit fields
SELECT *
FROM stg.stg_order_items
WHERE batch_id IS NULL
   OR file_row_number IS NULL
   OR insert_dt IS NULL;

-- file_row_number must be positive
SELECT *
FROM stg.stg_order_items
WHERE file_row_number <= 0;

--7 Parent–Child Consistency Check
-- Order items without matching order header
SELECT oi.*
FROM stg.stg_order_items oi
LEFT JOIN stg.stg_orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

--8 Duplicate Full Row Check
-- Exact duplicate order item rows
SELECT 
    order_id,
    order_item_id,
    product_id,
    quantity,
    COUNT(*) AS cnt
FROM stg.stg_order_items
GROUP BY 
    order_id,
    order_item_id,
    product_id,
    quantity
HAVING COUNT(*) > 1;

--1 Row Count Validation
-- Total number of dates
SELECT COUNT(*) AS total_dates
FROM dw.dim_date;

--2️ Primary Key Validation
-- date_key must not be NULL
SELECT *
FROM dw.dim_date
WHERE date_key IS NULL;

-- date_key must be unique
SELECT date_key, COUNT(*) AS cnt
FROM dw.dim_date
GROUP BY date_key
HAVING COUNT(*) > 1;

--3️ Date Column Validation
-- full_date must not be NULL
SELECT *
FROM dw.dim_date
WHERE full_date IS NULL;

-- date_key must match full_date (YYYYMMDD)
SELECT *
FROM dw.dim_date
WHERE date_key <> CONVERT(INT, FORMAT(full_date, 'yyyyMMdd'));

--4️ Calendar Attribute Validation
-- Year should match full_date
SELECT *
FROM dw.dim_date
WHERE yr <> YEAR(full_date);

-- Month number mismatch
SELECT *
FROM dw.dim_date
WHERE mon <> MONTH(full_date);

-- Day number mismatch
SELECT *
FROM dw.dim_date
WHERE day <> DAY(full_date);

--5️ Day / Month Name Validation
-- Day name mismatch
SELECT *
FROM dw.dim_date
WHERE day_of_week <> DATENAME(WEEKDAY, full_date);


--6 Weekend Flag Validation (if present)
-- Weekend flag check
SELECT *
FROM dw.dim_date
WHERE is_weekend = 'y'
  AND DATENAME(WEEKDAY, full_date) NOT IN ('Saturday','Sunday');

--7 Date Range Coverage
-- Minimum and maximum dates
SELECT 
    MIN(full_date) AS min_date,
    MAX(full_date) AS max_date
FROM dw.dim_date;



--1️ Row Count Validation
-- Total customer dimension rows
SELECT COUNT(*) AS total_rows
FROM dw.dim_customer;

--2️ Surrogate Key Validation
-- customer_key must not be NULL
SELECT *
FROM dw.dim_customer
WHERE customer_key IS NULL;

-- customer_key must be unique
SELECT customer_key, COUNT(*) AS cnt
FROM dw.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

--3️ Business Key Validation
-- customer_id must not be NULL
SELECT *
FROM dw.dim_customer
WHERE customer_id IS NULL;

--4️ SCD ACTIVE RECORD VALIDATION
--Only ONE active record per customer_id

SELECT customer_id, COUNT(*) AS active_cnt
FROM dw.dim_customer
WHERE current_flag = 1
GROUP BY customer_id
HAVING COUNT(*) > 1;

--5️ Date Range Validation (SCD Logic)
-- start_dt should always be <= end_dt
SELECT *
FROM dw.dim_customer
WHERE start_dt > end_dt;

--6️ Current Record Validation
-- Active records should have end_dt = '9999-12-31'
SELECT *
FROM dw.dim_customer
WHERE current_flag = 1
  AND end_dt <> '9999-12-31';

--7️ Inactive Record Validation
-- Inactive records should have active_flag = 0
SELECT *
FROM dw.dim_customer
WHERE current_flag = 0
  AND end_dt = '9999-12-31';

--8️ Overlapping History Check (Critical)
SELECT c1.customer_id, c1.start_dt, c1.end_dt,
       c2.start_dt AS overlap_start, c2.end_dt AS overlap_end
FROM dw.dim_customer c1
JOIN dw.dim_customer c2
  ON c1.customer_id = c2.customer_id
 AND c1.customer_key <> c2.customer_key
 AND c1.start_dt < c2.end_dt
 AND c2.start_dt < c1.end_dt;

--9️ Audit Column Validation
-- insert_dt must not be NULL
SELECT *
FROM dw.dim_customer
WHERE insert_dt IS NULL;



--1 Row Count Validation
SELECT COUNT(*) AS total_rows
FROM dw.dim_product;

--2️ Surrogate Key Validation
-- product_key must not be NULL
SELECT *
FROM dw.dim_product
WHERE product_key IS NULL;

-- product_key must be unique
SELECT product_key, COUNT(*) AS cnt
FROM dw.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1;

--3️ Business Key Validation
-- product_id must not be NULL
SELECT *
FROM dw.dim_product
WHERE product_id IS NULL;

-- product_id should be unique (Type-1 dimension)
SELECT product_id, COUNT(*) AS cnt
FROM dw.dim_product
GROUP BY product_id
HAVING COUNT(*) > 1;

--4️ Attribute Completeness Checks
-- product_name should not be NULL
SELECT *
FROM dw.dim_product
WHERE product_name IS NULL;

-- category should not be NULL
SELECT *
FROM dw.dim_product
WHERE category IS NULL;

-- brand should not be NULL
SELECT *
FROM dw.dim_product
WHERE brand IS NULL;

--5️ Data Quality Checks
-- Trim / blank check
SELECT *
FROM dw.dim_product
WHERE LTRIM(RTRIM(product_name)) = ''
   OR LTRIM(RTRIM(category)) = ''
   OR LTRIM(RTRIM(brand)) = '';

--6️ Audit Column Validation
-- insert_dt must not be NULL
SELECT *
FROM dw.dim_product
WHERE insert_dt IS NULL;

--7️ Source-to-Target Reconciliation (Optional but Good for GitHub)
SELECT COUNT(DISTINCT product_id) AS stg_product_cnt
FROM stg.stg_products;

SELECT COUNT(DISTINCT product_id) AS dim_product_cnt
FROM dw.dim_product;



--1 Row Count Validation
SELECT COUNT(*) AS total_rows
FROM dw.dim_store;

--2️ Surrogate Key Validation
-- store_key must not be NULL
SELECT *
FROM dw.dim_store
WHERE store_key IS NULL;

-- store_key must be unique
SELECT store_key, COUNT(*) AS cnt
FROM dw.dim_store
GROUP BY store_key
HAVING COUNT(*) > 1;

--3️ Business Key Validation
-- store_id must not be NULL
SELECT *
FROM dw.dim_store
WHERE store_id IS NULL;

-- store_id must be unique
SELECT store_id, COUNT(*) AS cnt
FROM dw.dim_store
GROUP BY store_id
HAVING COUNT(*) > 1;

--4️ Attribute Completeness Checks
-- store_name must not be NULL
SELECT *
FROM dw.dim_store
WHERE store_name IS NULL;

-- city must not be NULL
SELECT *
FROM dw.dim_store
WHERE city IS NULL;

-- state must not be NULL
SELECT *
FROM dw.dim_store
WHERE state IS NULL;

--5️ Data Quality Checks
-- Blank / whitespace values
SELECT *
FROM dw.dim_store
WHERE LTRIM(RTRIM(store_name)) = ''
   OR LTRIM(RTRIM(city)) = ''
   OR LTRIM(RTRIM(state)) = '';

--6️ Audit Column Validation
-- insert_dt must not be NULL
SELECT *
FROM dw.dim_store
WHERE insert_dt IS NULL;

--7️ Source-to-Target Reconciliation
SELECT COUNT(DISTINCT store_id) AS stg_store_cnt
FROM stg.stg_stores;

SELECT COUNT(DISTINCT store_id) AS dim_store_cnt
FROM dw.dim_store;



--1 Row Count Validation
SELECT COUNT(*) AS total_rows
FROM fact.fact_orders;

--2️ Surrogate Key Validation
-- order_key must not be NULL
SELECT *
FROM fact.fact_orders
WHERE order_key IS NULL;

-- order_key must be unique
SELECT order_key, COUNT(*) AS cnt
FROM fact.fact_orders
GROUP BY order_key
HAVING COUNT(*) > 1;

--3️ Business Key Validation
-- order_id must be unique
SELECT order_id, COUNT(*) AS cnt
FROM fact.fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- order_id must not be NULL
SELECT *
FROM fact.fact_orders
WHERE order_id IS NULL;

--4️ Date Key Validation (FK → dim_date)
-- Orphan order_date_key

SELECT f.*
FROM fact.fact_orders f
LEFT JOIN dw.dim_date d
  ON f.order_date_key = d.date_key
WHERE d.date_key IS NULL;

--5️ Customer Foreign Key Validation
SELECT f.*
FROM fact.fact_orders f
LEFT JOIN dw.dim_customer c
  ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

--6️ Store Foreign Key Validation
SELECT f.*
FROM fact.fact_orders f
LEFT JOIN dw.dim_store s
  ON f.store_key = s.store_key
WHERE s.store_key IS NULL;

--7️ Measure Validation (Amounts)
-- total_amount must be >= 0
SELECT *
FROM fact.fact_orders
WHERE total_amount < 0;

-- total_amount should not be NULL
SELECT *
FROM fact.fact_orders
WHERE total_amount IS NULL;

--8️ Payment Method Validation
-- unexpected payment methods
SELECT DISTINCT payment_method
FROM fact.fact_orders;


--(Expected: UPI, Card, Cash)

--9️ Audit Column Validation
-- insert_dt must not be NULL
SELECT *
FROM fact.fact_orders
WHERE insert_dt IS NULL;

--1️0 Source-to-Target Reconciliation
SELECT COUNT(DISTINCT order_id) AS stg_orders
FROM stg.stg_orders;

SELECT COUNT(DISTINCT order_id) AS fact_orders
FROM fact.fact_orders;

--1 Row Count Validation
SELECT COUNT(*) AS total_rows
FROM fact.fact_order_items;

--2 Surrogate Key Validation
-- fact_id must not be NULL
SELECT *
FROM fact.fact_order_items
WHERE fact_id IS NULL;

-- fact_id must be unique
SELECT fact_id, COUNT(*) AS cnt
FROM fact.fact_order_items
GROUP BY fact_id
HAVING COUNT(*) > 1;

--3 Business Key Validation
-- order_item_id should not be NULL
SELECT *
FROM fact.fact_order_items
WHERE order_item_id IS NULL;

-- order_id must not be NULL
SELECT *
FROM fact.fact_order_items
WHERE order_id IS NULL;

--4 Date Key Validation (FK → dim_date)
SELECT f.*
FROM fact.fact_order_items f
LEFT JOIN dw.dim_date d
  ON f.order_date_key = d.date_key
WHERE d.date_key IS NULL;

--5 Customer Foreign Key Validation
SELECT f.*
FROM fact.fact_order_items f
LEFT JOIN dw.dim_customer c
  ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

--6 Product Foreign Key Validation
SELECT f.*
FROM fact.fact_order_items f
LEFT JOIN dw.dim_product p
  ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

--7 Store Foreign Key Validation
SELECT f.*
FROM fact.fact_order_items f
LEFT JOIN dw.dim_store s
  ON f.store_key = s.store_key
WHERE s.store_key IS NULL;

--8 Quantity & Price Validation
-- quantity must be > 0
SELECT *
FROM fact.fact_order_items
WHERE quantity <= 0;

-- unit_price must be >= 0
SELECT *
FROM fact.fact_order_items
WHERE unit_price < 0;

--9 Line Total Calculation Validation
SELECT *
FROM fact.fact_order_items
WHERE line_total <> quantity * unit_price;

--10 Fact-to-Fact Reconciliation (CRITICAL)
-- Order Total vs Sum of Line Totals
SELECT 
    o.order_id,
    o.total_amount AS order_total,
    SUM(i.line_total) AS item_total
FROM fact.fact_orders o
JOIN fact.fact_order_items i
  ON o.order_id = i.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> SUM(i.line_total);


--(Expected: 0 rows)

--11 Duplicate Order Item Check
SELECT order_id, order_item_id, COUNT(*) AS cnt
FROM fact.fact_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

--12 Audit Column Validation
SELECT *
FROM fact.fact_order_items
WHERE insert_dt IS NULL;
-----------------------------------------------------------

/* =====================================================
   FACT-TO-FACT BUSINESS SANITY CHECK
   Order total vs sum of order items
   Expected result: 0 rows
   ===================================================== */

-- Order total vs order items total check
SELECT 
    f.order_id,
    f.total_amount,
    SUM(i.line_total) AS item_total
FROM fact.fact_orders f
JOIN fact.fact_order_items i
    ON f.order_id = i.order_id
GROUP BY f.order_id, f.total_amount
HAVING f.total_amount <> SUM(i.line_total);





