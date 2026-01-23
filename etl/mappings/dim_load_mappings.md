# Dimension Load Mappings (IICS)

## Overview
Dimension mappings populate the `dw` schema dimension tables.
They apply Slowly Changing Dimension (SCD) logic to track
attribute changes where required.

---

## Dimensions Covered
- dw.dim_date
- dw.dim_customer
- dw.dim_product
- dw.dim_store

---

## dw.dim_date (Static Dimension)

### Source
- Derived from order_date in stg.stg_orders

### Logic
- Pre-populated calendar table
- One row per date
- No updates once inserted

### Load Type
- Initial one-time load
- Incremental insert for new dates only

---

## dw.dim_customer (SCD Type 2)

### Source
- stg.stg_customers

### Business Key
- customer_id

### Change Tracking Columns
- first_name
- last_name
- email
- phone
- city
- state
- postal_code

### SCD Logic
- If customer_id does not exist → INSERT new record
- If attributes changed:
  - Expire existing record (end_dt = current date)
  - Set current_flag = 0
  - Insert new record with:
    - start_dt = current date
    - end_dt = '9999-12-31'
    - current_flag = 1
- If no change → no action

---

## dw.dim_product (SCD Type 1)

### Source
- stg.stg_products

### Business Key
- product_id

### Logic
- Overwrite existing attribute values
- No history maintained

### Updated Columns
- product_name
- category
- brand
- unit_price

---

## dw.dim_store (SCD Type 1)

### Source
- stg.stg_stores

### Business Key
- store_id

### Logic
- Overwrite existing attribute values
- No historical tracking

---

## Load Sequence
1. dim_date
2. dim_customer
3. dim_product
4. dim_store

---

## Error Handling
- Reject records with missing business keys
- Log rejected records for analysis
