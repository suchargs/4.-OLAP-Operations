CREATE DATABASE sales_data;
CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC
);
select * from sales_sample;

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

SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id;

SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY ROLLUP (Region, Product_Id)
ORDER BY Region, Product_Id;

SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY CUBE (Region, Product_Id, Date)
ORDER BY Region, Product_Id, Date;

SELECT *
FROM sales_sample
WHERE Region = 'East' AND Date BETWEEN '2024-01-01' AND '2024-01-07';

SELECT *
FROM sales_sample
WHERE Product_Id IN (1, 3) AND Region = 'West' AND Date >= '2024-01-05';