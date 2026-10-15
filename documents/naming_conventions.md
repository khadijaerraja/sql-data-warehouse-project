# 📘 Naming Conventions

This document defines the naming conventions used across the data warehouse project.

## 🎯 General Rules

- Use lowercase `snake_case` for object and column names.
- Use English for naming database objects.
- Use descriptive names that reflect the purpose of each object.
- Keep naming consistent across all layers.

## 🗂️ Table and View Naming

### 🥉 Bronze Layer

Stores raw data loaded from source CSV files.

- Follow the pattern `<source>_<entity>`.
- Keep source table names recognizable.

| Example | Description |
|---|---|
| `bronze.crm_cust_info` | Raw CRM customer data |
| `bronze.crm_sales_details` | Raw CRM sales data |
| `bronze.erp_cust_az12` | Raw ERP customer data |

### 🥈 Silver Layer

Contains cleaned and standardized data from Bronze.

- Keep the same table names as their Bronze counterparts.
- Apply data cleaning and transformation without changing the source-based naming pattern.

| Example | Description |
|---|---|
| `silver.crm_cust_info` | Cleaned customer data |
| `silver.crm_prd_info` | Standardized product data |
| `silver.erp_loc_a101` | Standardized location data |

### 🥇 Gold Layer

Contains business-ready views designed for analytics and reporting.

Use prefixes to identify the purpose of each view.

| Prefix | Purpose | Example |
|---|---|---|
| `dim_` | Dimension view | `gold.dim_customers` |
| `dim_` | Dimension view | `gold.dim_products` |
| `fact_` | Fact view | `gold.fact_sales` |

## 🏷️ Column Naming

### Business Columns

Use descriptive names in Gold to make data easier to understand and query.

| Example | Description |
|---|---|
| `customer_id` | Customer identifier |
| `product_name` | Product name |
| `sales_amount` | Sales amount |
| `order_date` | Order date |

### Surrogate Keys

Use the `_key` suffix for surrogate keys generated in Gold dimension views.

| Column | Table |
|---|---|
| `customer_key` | `gold.dim_customers` |
| `product_key` | `gold.dim_products` |

### Source Columns

Bronze and Silver retain source-oriented column names, such as `cst_id`, `prd_key`, and `sls_ord_num`, to maintain traceability to the original datasets.

## ⚙️ Stored Procedure Naming

Use the pattern `load_<layer>` for procedures responsible for loading a data warehouse layer.

| Procedure | Purpose |
|---|---|
| `bronze.load_bronze` | Loads raw data from CSV files into Bronze |
| `silver.load_silver` | Transforms and loads data from Bronze into Silver |

## 🔄 Data Processing Rules

- **Bronze:** Load raw data from source files.
- **Silver:** Clean, standardize, and validate source data.
- **Gold:** Combine Silver data into business-oriented dimension and fact views.
- **Logging:** Display load status, duration, and error details during Bronze and Silver processing.

