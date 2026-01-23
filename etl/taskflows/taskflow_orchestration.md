# Taskflow Orchestration (IICS)

## Overview
This project uses Informatica IICS taskflows to
control ETL execution order and handle dependencies
between staging, dimensions, and facts.

---

## Taskflow Layers

### 1. Staging Taskflow
Loads raw source data into staging tables.

**Tables Loaded (Parallel):**
- stg_customers
- stg_products
- stg_stores
- stg_orders
- stg_order_items

**Why Parallel?**
- No inter-table dependencies
- Faster ingestion

---

### 2. Dimension Taskflow
Loads dimensions after staging is complete.

**Execution Order:**
1. dim_date
2. dim_customer (SCD Type 2)
3. dim_product (SCD Type 1)
4. dim_store (SCD Type 1)

**Why Sequential?**
- Surrogate key dependencies
- Historical accuracy

---

### 3. Fact Taskflow
Loads fact tables only after all dimensions succeed.

**Execution Order:**
1. fact_orders
2. fact_order_items

**Rules:**
- Facts never load before dimensions
- Orphan records are rejected

---

## Error Handling
- Each layer has its own taskflow
- Failure stops downstream execution
- Error logs available in IICS

---

## Restartability
- Taskflows can restart from failed step
- Batch ID ensures idempotency
- Partial loads are prevented

---

## Best Practices Applied
- Dependency-driven execution
- Clear separation of concerns
- Production-grade reliability
