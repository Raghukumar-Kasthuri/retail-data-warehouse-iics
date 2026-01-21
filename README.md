# retail-data-warehouse-iics
End-to-End Retail Data Warehouse using IICS
# Retail Data Warehouse Project (IICS)

## 📌 Project Overview
This project demonstrates an end-to-end retail data warehouse built using
Informatica Intelligent Cloud Services (IICS) and SQL Server.

The goal is to design and implement a scalable dimensional model,
handle incremental loads, and ensure data quality through validations.

---

## 🏗️ Architecture
- Source: CSV files
- Staging Layer: stg schema
- Data Warehouse: dw schema
- Facts: fact schema
- ETL Tool: Informatica IICS
- Database: SQL Server

---

## 📊 Data Model
### Dimensions
- dim_date
- dim_customer (SCD Type 2)
- dim_product (SCD Type 1)
- dim_store (SCD Type 1)

### Facts
- fact_orders (Order-level grain)
- fact_order_items (Product-level grain)

---

## 🔄 ETL Design
- Separate staging, dimension, and fact loads
- Surrogate keys for all dimensions
- Business keys used for lookups
- Null-safe change detection logic
- Insert and update paths clearly separated

---

## ✅ Data Validation
- Row count reconciliation
- Null checks
- Duplicate checks
- Surrogate key validation
- Fact-to-dimension integrity checks

---

## 🚀 Skills Demonstrated
- Dimensional Modeling
- SCD Type 1 & Type 2
- Fact grain design
- IICS mappings & taskflows
- SQL validations
- Production-ready ETL design

---

## 👤 Author
Built and documented by Raghukumar Kasthuri
