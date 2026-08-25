/*9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage*/

WITH CTE AS(SELECT channel,
           CONCAT(ROUND(SUM(sold_quantity*gross_price)/1000000,2),"M") AS gross_sales_mln
		   FROM dim_customer c 
           JOIN fact_sales_monthly s 
           ON c.customer_code=s.customer_code
           JOIN fact_gross_price g 
           ON g.product_code=s.product_code
           AND g.fiscal_year=s.fiscal_year
           WHERE s.fiscal_year=2021
           GROUP BY channel
           ORDER BY gross_sales_mln DESC)

SELECT *, ROUND(gross_sales_mln*100/SUM(gross_sales_mln) OVER(),2) AS percentage
FROM CTE
ORDER BY percentage DESC;
