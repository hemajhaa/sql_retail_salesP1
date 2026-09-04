--SQL Retail sale PROJECT - 1
CREATE DATABASE sql_projectP1;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
        (
         transactions_id INT PRIMARY KEY,
         sale_date	DATE,
         sale_time TIME,
         customer_id INT,
         gender	VARCHAR(15),
         age INT,
		 category VARCHAR(15),	
         quantiy INT,
         price_per_unit	INT,
         cogs FLOAT,
         total_sale FLOAT
        )

SELECT * FROM retail_sales
LIMIT 15
SELECT COUNT (*) FROM retail_sales



-- DATA EXPLORATION 
-- HOW MANYB SALES WE HAVE 
SELECT COUNT(*) FROM retail_sales


-- HOW ANY CUSTOMERS WE HAVE ?
SELECT COUNT(customer_id) FROM retail_sales 

-- HOW MANY UNIQUE CUSTOMERS ARE THEIR ?
SELECT COUNT ( DISTINCT customer_id) FROM retail_sales

-- HOW MANY UNIQUE CATEGORY WE HAVE?
SELECT  DISTINCT category FROM retail_sales


-- BUSINESS KEY PROBLEM & ANSWER -- BUSINESS ANALYSIS :
-- MY ANALYSIS AND FINDINGS
-- Q.1 Write a SQL query to retrieve all columns for sale mode on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the Quantity is sold more than 4 month of Nov -2022
-- Q.3 Write a SQL query to calculate the total sales (total_sales)for each category.
-- Q.4 Write a SQL query to find the avergae of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to Calculate Total Revenue, Total COGS and Total Profit.
-- Q.6 Write the SQL query to find Which Product Category Generates the Highest Profit?
-- Q.7 Write SQL query to find Top 10 Customers by Total Spending?
-- Q.8 Write a SQL query to create each shift and number of oders (Example Morning <=12, Afternoon Between 12 & 17 , Evening > 17)
-- Q.9 Write a SQL query to find all transactions where the etotal_sales is greater than 1000.
-- Q.10 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in the each category .


-- SOLUTIONS ;

-- Q.1 Write a SQL query to retrieve all columns for sale mode on '2022-11-05'?
SELECT * 
FROM
retail_sales 
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the Quantity is sold more than 4 month of Nov -2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
 AND 
 TO_CHAR(sale_date, 'YYYY-MM')= '2022-11'
 AND 
 quantiy >= 4


-- Q.3 Write a SQL query to calculate the total sales (total_sales)for each category.
SELECT
SUM(total_sale) AS total_sale,category
FROM retail_sales
GROUP BY category

-- Q.4 Write a SQL query to find the averge age of customers who purchased items from the 'Beauty' category.
SELECT
ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q.5 Write a SQL query to Calculate Total Revenue, Total COGS and Total Profit.

SELECT 
    SUM(total_sale) AS total_revenue,
    SUM(cogs) AS total_cogs,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales;

-- Q.6 Write the SQL query to find Which Product Category Generates the Highest Profit?
SELECT 
SUM(total_sale - cogs) AS highest_profit,category
FROM retail_sales
GROUP BY category 
LIMIT  1

-- Q.7 Write SQL query to find Top 10 Customers by Total Spending?
SELECT customer_id,
SUM(total_sale) as Total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_spending DESC
LIMIT 10;

-- Q.8 Write a SQL query to create each shift and number of oders (Example Morning <=12, Afternoon Between 12 & 17 , Evening > 17)

SELECT 
    CASE
        WHEN EXTRACT (HOUR sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT (HOUR sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales
SELECT 
shift,
COUNT (*) AS total_orders
FROM hourly_sale
GROUP BY shift
-- Q.9 Write a SQL query to find all transactions where the total_sales is greater than 1000.
SELECT 
transactions_id ,
total_sale
FROM 
retail_sales
WHERE 
total_sale > 1000
GROUP BY transactions_id;

--  Write a SQL query to find the total number of transactions (transaction_id) made by each gender in the each category .
SELECT category,
gender,
COUNT(*) AS total_trans FROM retail_sales
GROUP BY gender,
category
ORDER BY 1

--END OF PROJECT:


