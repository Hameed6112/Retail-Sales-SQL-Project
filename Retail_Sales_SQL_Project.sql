-- ==========================================
-- RETAIL SALES ANALYSIS PROJECT
-- SQL SERVER (SSMS)
-- ==========================================

-- Create Database
CREATE DATABASE SQL_Retail_Project;
GO

USE SQL_Retail_Project;
GO

-- ==========================================
-- DATA EXPLORATION
-- ==========================================

-- View Data
SELECT *
FROM retail_sales_new;

-- Total Number of Records
SELECT COUNT(*) AS Total_Rows
FROM retail_sales_new;

-- ==========================================
-- DATA CLEANING
-- ==========================================

-- Check NULL Values
SELECT *
FROM retail_sales_new
WHERE transactions_Id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete NULL Records
DELETE FROM retail_sales_new
WHERE transactions_Id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- ==========================================
-- BUSINESS ANALYSIS
-- ==========================================

-- Q1. Retrieve all sales made on 2022-11-05

SELECT *
FROM retail_sales_new
WHERE sale_date = '2022-11-05';


-- Q2. Retrieve all Clothing category records

SELECT *
FROM retail_sales_new
WHERE category = 'Clothing';


-- Q3. Calculate total sales for each category

SELECT
    category,
    SUM(total_sale) AS Total_Sales
FROM retail_sales_new
GROUP BY category;


-- Q4. Find average age of customers who purchased Beauty products

SELECT
    AVG(age) AS Average_Age
FROM retail_sales_new
WHERE category = 'Beauty';


-- Q5. Find transactions where total sale is greater than 1000

SELECT *
FROM retail_sales_new
WHERE total_sale > 1000;


-- Q6. Find total transactions by gender and category

SELECT
    gender,
    category,
    COUNT(transactions_id) AS Total_Transactions
FROM retail_sales_new
GROUP BY gender, category
ORDER BY gender, category;


-- Q7. Calculate average sale for each month and rank them

SELECT
    YEAR(sale_date) AS Sales_Year,
    MONTH(sale_date) AS Sales_Month,
    AVG(total_sale) AS Avg_Sale,
    RANK() OVER
    (
        PARTITION BY YEAR(sale_date)
        ORDER BY AVG(total_sale) DESC
    ) AS Rank_No
FROM retail_sales_new
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date);


-- Q8. Find Top 5 Customers based on Total Sales

SELECT TOP 5
    customer_id,
    SUM(total_sale) AS Total_Sales
FROM retail_sales_new
GROUP BY customer_id
ORDER BY Total_Sales DESC;


-- Q9. Find unique customers in each category

SELECT
    category,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_sales_new
GROUP BY category
ORDER BY Unique_Customers DESC;


-- Q10. Create shifts and count number of orders

SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift_Name,
    COUNT(transactions_id) AS Number_Of_Orders
FROM retail_sales_new
GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY Number_Of_Orders DESC;

-- ==========================================
-- END OF PROJECT
-- ==========================================
