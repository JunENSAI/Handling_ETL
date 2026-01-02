/*
   CTE & Window Functions

   Scenario: We have a staging table 'stg_sales' with duplicate entries
   and messy data. We need to create a clean view.
*/

-- 1. SETUP: Create a dummy staging table with duplicates
CREATE TABLE IF NOT EXISTS stg_sales (
    transaction_id INT,
    product_name VARCHAR(50),
    sale_amount NUMERIC(10, 2),
    sale_date TIMESTAMP
);

-- Insert dummy data
INSERT INTO stg_sales VALUES
(101, 'Widget A', 50.00, '2023-10-01 10:00:00'),
(101, 'Widget A', 50.00, '2023-10-01 10:05:00'), 
(102, 'Widget B', 25.00, '2023-10-01 11:00:00'),
(103, 'Widget C', 100.00, '2023-10-01 12:00:00');


-- 2. EXERCISE: The Deduplication Pattern
-- We want to keep ONLY the most recent version of Transaction 101.

WITH RankedSales AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id
            ORDER BY sale_date DESC
        ) as row_num
    FROM
        stg_sales
)
SELECT
    transaction_id,
    product_name,
    sale_amount,
    sale_date
FROM
    RankedSales
WHERE
    row_num = 1;


-- 3. EXERCISE: Using LEAD/LAG for Analysis
-- Calculate the time difference between sales.

SELECT
    transaction_id,
    sale_date,
    LAG(sale_date) OVER (ORDER BY sale_date) as previous_sale_date,
    sale_date - LAG(sale_date) OVER (ORDER BY sale_date) as time_since_last_sale
FROM
    stg_sales
ORDER BY
    sale_date;