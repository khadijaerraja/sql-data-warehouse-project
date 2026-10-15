/*
===============================================================================
Gold Layer - Data Quality Validation
===============================================================================
Purpose:
    Validate the quality of the analytical dataset by checking key uniqueness
    and verifying relationships between the fact table and dimension tables.

Validation Rules:
    1. Customer dimension keys must be unique.
    2. Product dimension keys must be unique.
    3. Sales records must reference existing customers and products.

Expected Outcome:
    All validation queries should return zero rows when the data model
    satisfies the defined quality requirements.
===============================================================================
*/

-- ----------------------------------------------------------------------------
-- Rule 1: Validate customer dimension keys
-- ----------------------------------------------------------------------------
SELECT
    customer_key,
    COUNT(*) AS occurrence_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ----------------------------------------------------------------------------
-- Rule 2: Validate product dimension keys
-- ----------------------------------------------------------------------------
SELECT
    product_key,
    COUNT(*) AS occurrence_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ----------------------------------------------------------------------------
-- Rule 3: Check referential integrity in the sales fact table
-- ----------------------------------------------------------------------------
SELECT
    f.*
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
WHERE c.customer_key IS NULL
   OR p.product_key IS NULL;
