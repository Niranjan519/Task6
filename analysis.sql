-- 1. SETUP DATABASE
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- 2. CREATE TABLE
-- Using DECIMAL(10, 2) for currency fields to ensure precision.
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    Product_Type VARCHAR(255),
    Net_Quantity INT,
    Gross_Sales DECIMAL(10, 2),
    Discounts DECIMAL(10, 2),
    Returns DECIMAL(10, 2),
    Total_Net_Sales DECIMAL(10, 2)
);

-- 3. LOAD DATA
-- IMPORTANT: Replace '/path/to/your/business.retailsales.csv' with the correct path.
-- Ensure the file is accessible to your MySQL instance.
LOAD DATA INFILE '/path/to/your/business.retailsales.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip the header row: Product Type,Net Quantity,Gross Sales,Discounts,Returns,Total Net Sales
SELECT
    -- Hint (a): Use STRFTIME for month/year extraction in SQLite
    STRFTIME('%Y', order_date) AS Sale_Year,
    STRFTIME('%m', order_date) AS Sale_Month,
    
    -- Hint (d): COUNT(DISTINCT order_id) - Proxy used due to missing order_id column.
    -- Counts distinct customer-date combinations as a proxy for transaction volume.
    CAST(COUNT(DISTINCT customer_id || '-' || order_date) AS INTEGER) AS Order_Volume_Transactions,
    
    -- Hint (c): Use SUM() for revenue calculation
    ROUND(SUM(quantity * price), 2) AS Monthly_Revenue
FROM
    sales_data
WHERE
    -- Hint (f): Limit results for a specific time period (e.g., Year 2024)
    STRFTIME('%Y', order_date) = '2024' 
GROUP BY
    Sale_Year,
    Sale_Month -- Hint (b): GROUP BY year/month
ORDER BY
    Sale_Year ASC,
    Sale_Month ASC; -- Hint (e): Use ORDER BY for sorting
