# Staging Load Mappings (IICS)

## Overview
These mappings load raw CSV source files into staging tables
under the `stg` schema. Minimal transformations are applied
to preserve source data for downstream processing.

---

## Source Details
- Source Type: Flat File (CSV)
- File Pattern: Incremental daily loads
- Delimiter: Comma (,)
- Header Row: Yes

---

## Target Tables
- stg.stg_customers
- stg.stg_products
- stg.stg_stores
- stg.stg_orders
- stg.stg_order_items

---

## Common Transformations
- Direct column mapping from source to staging
- Data type standardization
- Null handling for optional fields
- File metadata captured for auditing

---

## Audit Columns Logic
- file_name → populated from source filename
- file_row_number → populated using sequence
- batch_id → passed from IICS parameter
- insert_dt → system UTC timestamp
- update_dt → NULL for initial load
- load_user → IICS service account

---

## Error Handling
- Invalid rows redirected to reject files
- Mandatory field validation applied
- Load fails if file structure changes

---

## Load Type
- Truncate & Load (Staging only)
- No historical tracking in staging
