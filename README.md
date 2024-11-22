# 4.-OLAP-Operations

The project is done using MySQL and PostgreSQL as well.
Two separate SQL files are attached "Task 4.sql" - MySQL file and "Task_4_PostgreSQL.sql" - PostrgreSQL file

1. Database Creation
1.Create the database:
CREATE DATABASE sales_data;
USE sales_data;
2.Create the sales_sample table:
CREATE TABLE sales_sample ( 
Product_Id INTEGER, 
Region VARCHAR(50), 
Date DATE, Sales_Amount NUMERIC );
2. Data Creation
INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount) VALUES 
(1, 'East', '2024-01-01', 500), 
(2, 'West', '2024-01-02', 700), 
(3, 'East', '2024-01-03', 400), 
(4, 'North', '2024-01-04', 800), 
(5, 'South', '2024-01-05', 600), 
(1, 'West', '2024-01-06', 550), 
(3, 'East', '2024-01-07', 300), 
(2, 'North', '2024-01-08', 650), 
(4, 'South', '2024-01-09', 750), 
(1, 'West', '2024-01-10', 450);
Explanation: 10 sample records were inserted into the sales_sample table
3. OLAP Operations
a) Drill Down
Analyze sales data at a more detailed level (from region to product):
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Region, Product_Id 
ORDER BY Region, Product_Id;
Explanation: Groups the sales data by both Region and Product_Id to show the sales performance at a detailed level.
b) Rollup
Summarize sales data at different levels of granularity (from product to region):
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY ROLLUP (Region, Product_Id) 
ORDER BY Region, Product_Id;
Explanation:
The ROLLUP operator provides subtotals at each level.
Outputs total sales for each region, each product within the region, and a grand total for all regions.
c) Cube
Analyze sales data across multiple dimensions (product, region, and date):
SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY CUBE (Region, Product_Id, Date) 
ORDER BY Region, Product_Id, Date;
Explanation:
The CUBE operator generates all possible combinations of dimensions for aggregation.
Allows analysis of total sales by region, product, and date from various perspectives.
OR

While using MySQL we can replace cube function using UNION as MySQL doesn’t supports cube function. Below is the Query we can use while using MySQL platform.
1.Aggregation by Region, Product_Id, and Date 

SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Region, Product_Id, Date 
UNION ALL 

2. Aggregation by Region and Product_Id (ignoring Date) 

SELECT Region, Product_Id, NULL AS Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Region, Product_Id 
UNION ALL 
3. Aggregation by Region and Date (ignoring Product_Id) 
SELECT Region, NULL AS Product_Id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample 
GROUP BY Region, Date 
UNION ALL 
4. Aggregation by Product_Id and Date (ignoring Region) 
SELECT NULL AS Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Product_Id, Date 
UNION ALL 
5. Aggregation by Region only (ignoring Product_Id and Date) 
SELECT Region, NULL AS Product_Id, NULL AS Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Region 
UNION ALL 
6. Aggregation by Product_Id only (ignoring Region and Date) 
SELECT NULL AS Region, Product_Id, NULL AS Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Product_Id 
UNION ALL  
7. Aggregation by Date only (ignoring Region and Product_Id) 
SELECT NULL AS Region, NULL AS Product_Id, Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
GROUP BY Date 
UNION ALL 
8. Grand Total (ignoring Region, Product_Id, and Date) 
SELECT NULL AS Region, NULL AS Product_Id, NULL AS Date, SUM(Sales_Amount) AS Total_Sales 
FROM sales_sample 
ORDER BY Region, Product_Id, Date;

d) Slice

To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range. 

SELECT * 
FROM sales_sample 
WHERE Region = 'East' AND Date BETWEEN '2024-01-01' AND '2024-01-07';

Explanation: Filters the sales data to show records for the East region within a specified date range.

e) Dice
Extract data based on multiple criteria (e.g., specific product, region, and date):
SELECT * 
FROM sales_sample 
WHERE Product_Id IN (1, 3) AND Region = 'West' AND Date >= '2024-01-05';
Explanation: Combines filters for product IDs, region, and date to extract the desired subset of sales data.

