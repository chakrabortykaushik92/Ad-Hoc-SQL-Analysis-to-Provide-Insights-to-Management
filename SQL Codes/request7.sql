/*7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount*/

WITH CTE AS (SELECT c.customer_code,customer,s.fiscal_year,
             MONTHNAME(date) AS month_name,
             ROUND(sold_quantity*gross_price,2) 
             AS total_gross_sales
             FROM dim_customer c
             JOIN fact_sales_monthly s
             ON c.customer_code=s.customer_code
             JOIN fact_gross_price g
             ON g.product_code=s.product_code
             AND g.fiscal_year=s.fiscal_year
             WHERE customer="Atliq Exclusive")

SELECT month_name,fiscal_year,SUM(total_gross_sales) AS gross_sales_amount
FROM CTE
GROUP BY month_name,fiscal_year
ORDER BY gross_sales_amount DESC
