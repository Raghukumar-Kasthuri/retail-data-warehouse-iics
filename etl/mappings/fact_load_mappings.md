# Fact Load Mappings (IICS)

## Overview
Fact mappings populate the `fact` schema tables.
They join staging data with dimension tables to
retrieve surrogate keys before loading facts.

---

## Facts Covered
- fact.fact_orders
- fact.fact_order_items

---

## fact.fact_orders

### Source
- stg.stg_orders

### Dimension Lookups
| Dimension | Lookup Table | Join Condition |
|---------|--------------|----------------|
| Date | dw.dim_date | order_date = full_date |
| Customer | dw.dim_customer | customer_id + current_flag = 1 |
| Store | dw.dim_store | store_id |

### Measures
- total_amount

### Logic
- Lookup surrogate keys for date, customer, and store
- Reject records if any surrogate key is missing
- Insert one row per order

---

## fact.fact_order_items

### Source
- stg.stg_order_items

### Dimension Lookups
| Dimension | Lookup Table | Join Condition |
|---------|--------------|----------------|
| Date | dw.dim_date | order_date = full_date |
| Customer | dw.dim_customer | customer_id + current_flag = 1 |
| Product | dw.dim_product | product_id |
| Store | dw.dim_store | store_id |

### Measures
- quantity
- unit_price
- line_total

### Logic
- Retrieve all surrogate keys
- Calculate line_total if missing
- Insert one row per order item

---

## Load Sequence
1. fact_orders
2. fact_order_items

---

## Data Quality Rules
- No null surrogate keys
- Positive quantity and amounts
- Referential integrity enforced
