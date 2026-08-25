/*5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost*/

WITH CTE AS(
         SELECT p.product_code,product,manufacturing_cost,
         DENSE_RANK() OVER(ORDER BY manufacturing_cost DESC) 
         AS drn  FROM fact_manufacturing_cost m
		 JOIN dim_product p 
		 ON m.product_code=p.product_code)
SELECT product_code,product,manufacturing_cost FROM CTE
WHERE drn IN ((SELECT MAX(drn) FROM CTE),(SELECT MIN(drn) FROM CTE))
