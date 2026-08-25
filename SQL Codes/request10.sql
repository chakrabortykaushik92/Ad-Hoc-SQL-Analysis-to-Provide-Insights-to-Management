/*10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_orde*/

WITH CTE1 AS (WITH CTE AS(SELECT division,p.product_code,product,
						SUM(sold_quantity) AS total_sold_quantity
						FROM fact_sales_monthly s
						JOIN dim_product p
						ON s.product_code=p.product_code
						WHERE fiscal_year = 2021
						GROUP BY division,p.product_code,product)
			 SELECT *, DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC)
			 AS rank_order
             FROM CTE)
 SELECT *
 FROM CTE1
 WHERE rank_order<=3;
