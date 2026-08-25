/*6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
customer_code
customer
average_discount_percentage*/

WITH CTE AS(
       SELECT c.customer_code,customer,pre_invoice_discount_pct
       FROM dim_customer c
       JOIN fact_pre_invoice_deductions i
       ON c.customer_code=i.customer_code
       WHERE fiscal_year=2021 AND market="India")

SELECT customer_code,customer,ROUND(AVG(pre_invoice_discount_pct),4) AS average_discount_percentage
FROM CTE
GROUP BY customer_code,customer
ORDER BY average_discount_percentage DESC
LIMIT 5;
